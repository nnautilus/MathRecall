import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';
import 'package:mathrecall/infrastructure/media/image_storage.dart';

void main() {
  late AppDatabase db;
  late Directory root;
  late ImageStorage storage;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    root = await Directory.systemTemp.createTemp('mathrecall_images_');
    storage = ImageStorage(root, db);
  });

  tearDown(() async {
    await db.close();
    if (root.existsSync()) {
      await root.delete(recursive: true);
    }
  });

  test('stores content-addressed image and deduplicates', () async {
    final bytes = Uint8List.fromList(List.filled(64, 7));
    final first = await storage.storeBytes(bytes, sourceName: 'photo.jpg');
    final second = await storage.storeBytes(bytes, sourceName: 'other.jpg');

    expect(first.sha256, hasLength(64));
    expect(second.sha256, first.sha256);
    expect(storage.resolve(first.relPath).existsSync(), isTrue);
    expect(await db.select(db.imageAssets).get(), hasLength(1));
  });

  test('cleanup removes orphan files but keeps known assets', () async {
    final stored = await storage.storeBytes(
      Uint8List.fromList(List.filled(64, 9)),
      sourceName: 'a.jpg',
    );
    final orphan = File('${root.path}/images/original/orphan.jpg');
    await orphan.parent.create(recursive: true);
    await orphan.writeAsBytes([1, 2, 3]);

    final removed = await storage.cleanup();
    expect(removed, 1);
    expect(orphan.existsSync(), isFalse);
    expect(storage.resolve(stored.relPath).existsSync(), isTrue);
  });
}
