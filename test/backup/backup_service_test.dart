import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/core/errors/app_error.dart';
import 'package:mathrecall/domain/entities/backup.dart';
import 'package:mathrecall/infrastructure/backup/backup_service.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';
import 'package:mathrecall/infrastructure/repositories/question_repository_impl.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory temp;
  late File dbFile;
  late AppDatabase db;
  late BackupService service;

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('mathrecall_backup_test_');
    dbFile = File(p.join(temp.path, 'db', 'mathrecall.sqlite'));
    await dbFile.parent.create(recursive: true);
    db = AppDatabase(NativeDatabase(dbFile));
    service = BackupService(db: db, dbFile: dbFile, supportDir: temp);
  });

  tearDown(() async {
    await db.close();
    if (temp.existsSync()) await temp.delete(recursive: true);
  });

  Future<void> seedImage() async {
    const sha = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
    final file = File(p.join(temp.path, 'images', 'original', 'a.jpg'));
    await file.parent.create(recursive: true);
    await file.writeAsBytes([1, 2, 3, 4]);
    await db.into(db.imageAssets).insert(
          ImageAssetsCompanion.insert(
            sha256: sha,
            relPath: 'images/original/a.jpg',
            bytes: const Value(4),
          ),
        );
  }

  test('exports and restores questions and images', () async {
    final repo = QuestionRepositoryImpl(db);
    final id = await repo.create(
      promptLatex: r'求 $x^2=1$ 的解',
      answerLatex: r'$x=\pm1$',
    );
    await seedImage();

    final backup = await service.exportBackup();
    expect(backup.existsSync(), isTrue);
    final preview = await service.inspectBackup(backup);
    expect(preview.canRestore, isTrue);
    expect(preview.manifest.counts['questions'], 1);
    expect(preview.manifest.images, hasLength(1));

    await repo.softDelete(id);
    expect((await repo.list()).length, 0);

    final report = await service.restoreBackup(backup, confirmed: true);
    expect(report.restoredQuestions, 1);
    expect(report.restoredImages, 1);
    final restored = await repo.list();
    expect(restored, hasLength(1));
    expect(restored.single.promptLatex, r'求 $x^2=1$ 的解');
    expect(
      File(p.join(temp.path, 'images', 'original', 'a.jpg')).existsSync(),
      isTrue,
    );
  });

  test('rejects a backup with corrupted database hash', () async {
    final fakeDb = File(p.join(temp.path, 'fake.sqlite'));
    await fakeDb.writeAsBytes([1, 2, 3]);
    final manifest = BackupManifest(
      formatVersion: 1,
      appVersion: 'test',
      schemaVersion: db.schemaVersion,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      database: const BackupDatabaseInfo(
        path: 'database.sqlite',
        sha256:
            '0000000000000000000000000000000000000000000000000000000000000000',
        bytes: 3,
      ),
      images: const [],
      counts: const {},
    );
    final manifestFile = File(p.join(temp.path, 'manifest.json'));
    await manifestFile.writeAsString(jsonEncode(manifest.toJson()));
    final zip = File(p.join(temp.path, 'corrupt.zip'));
    final encoder = ZipFileEncoder();
    encoder.create(zip.path);
    await encoder.addFile(fakeDb, 'database.sqlite');
    await encoder.addFile(manifestFile, 'manifest.json');
    await encoder.close();

    await expectLater(
      service.inspectBackup(zip),
      throwsA(isA<AppError>()),
    );
  });

  test('failed restore does not remove current data', () async {
    final repo = QuestionRepositoryImpl(db);
    await repo.create(promptLatex: '保留我');
    final fakeDb = File(p.join(temp.path, 'fake2.sqlite'));
    await fakeDb.writeAsBytes([9, 9, 9]);
    final manifest = BackupManifest(
      formatVersion: 1,
      appVersion: 'test',
      schemaVersion: db.schemaVersion,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      database: const BackupDatabaseInfo(
        path: 'database.sqlite',
        sha256:
            '0000000000000000000000000000000000000000000000000000000000000000',
        bytes: 3,
      ),
      images: const [],
      counts: const {},
    );
    final manifestFile = File(p.join(temp.path, 'manifest2.json'));
    await manifestFile.writeAsString(jsonEncode(manifest.toJson()));
    final zip = File(p.join(temp.path, 'corrupt2.zip'));
    final encoder = ZipFileEncoder();
    encoder.create(zip.path);
    await encoder.addFile(fakeDb, 'database.sqlite');
    await encoder.addFile(manifestFile, 'manifest.json');
    await encoder.close();

    await expectLater(
      service.restoreBackup(zip, confirmed: true),
      throwsA(isA<AppError>()),
    );
    expect(await repo.list(), hasLength(1));
  });

  test('lists local backups newest first', () async {
    final first = await service.exportBackup();
    await Future<void>.delayed(const Duration(milliseconds: 20));
    final second = await service.exportBackup();
    final list = await service.listBackups();
    expect(list.length, 2);
    expect(list.first.name, second.uri.pathSegments.last);
    expect(list.any((item) => item.name == first.uri.pathSegments.last), isTrue);
  });
}
