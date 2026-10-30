import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// 按归一化矩形（0~1）裁剪图片，返回 PNG 字节。
Future<Uint8List> cropImageBytes(Uint8List bytes, Rect normalized) async {
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  final image = frame.image;
  final src = Rect.fromLTWH(
    (normalized.left.clamp(0.0, 1.0) * image.width),
    (normalized.top.clamp(0.0, 1.0) * image.height),
    (normalized.width.clamp(0.0, 1.0) * image.width),
    (normalized.height.clamp(0.0, 1.0) * image.height),
  );
  final width = src.width.round().clamp(1, image.width);
  final height = src.height.round().clamp(1, image.height);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawImageRect(
    image,
    src,
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint(),
  );
  final picture = recorder.endRecording();
  final cropped = await picture.toImage(width, height);
  final data = await cropped.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  cropped.dispose();
  if (data == null) {
    throw StateError('图片裁剪失败');
  }
  return data.buffer.asUint8List();
}

/// 识别前框选区域：返回归一化矩形（相对原图），取消返回 null。
class ImageRegionSelectPage extends StatefulWidget {
  const ImageRegionSelectPage({super.key, required this.imageBytes});

  final Uint8List imageBytes;

  @override
  State<ImageRegionSelectPage> createState() => _ImageRegionSelectPageState();
}

class _ImageRegionSelectPageState extends State<ImageRegionSelectPage> {
  ui.Image? _image;
  Rect? _selection;
  Offset? _dragStart;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _decode();
  }

  Future<void> _decode() async {
    final codec = await ui.instantiateImageCodec(widget.imageBytes);
    final frame = await codec.getNextFrame();
    if (!mounted) return;
    setState(() {
      _image = frame.image;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('框选识别区域')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '在图片上拖动画框，只识别框内区域；不框选可返回使用整图。',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Expanded(child: _imageArea()),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('取消'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(
                                  const Rect.fromLTWH(0, 0, 1, 1),
                                ),
                                child: const Text('使用整图'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _selection == null || _selection!.isEmpty
                                ? null
                                : () => Navigator.of(context).pop(_selection),
                            child: const Text('识别框内区域'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _imageArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final image = _image!;
        final scale = math.min(
          constraints.maxWidth / image.width,
          constraints.maxHeight / image.height,
        );
        final displayWidth = image.width * scale;
        final displayHeight = image.height * scale;
        final offset = Offset(
          (constraints.maxWidth - displayWidth) / 2,
          (constraints.maxHeight - displayHeight) / 2,
        );
        Rect? displayRect;
        if (_selection != null) {
          displayRect = Rect.fromLTWH(
            offset.dx + _selection!.left * displayWidth,
            offset.dy + _selection!.top * displayHeight,
            _selection!.width * displayWidth,
            _selection!.height * displayHeight,
          );
        }
        return GestureDetector(
          onPanStart: (details) {
            _dragStart = _clampToImage(details.localPosition, offset, scale);
            setState(() => _selection = null);
          },
          onPanUpdate: (details) {
            final start = _dragStart;
            if (start == null) return;
            final current =
                _clampToImage(details.localPosition, offset, scale);
            final rect = Rect.fromPoints(start, current);
            final normalized = Rect.fromLTWH(
              (rect.left - offset.dx) / displayWidth,
              (rect.top - offset.dy) / displayHeight,
              rect.width / displayWidth,
              rect.height / displayHeight,
            );
            setState(() => _selection = _normalize(normalized));
          },
          onPanEnd: (_) => _dragStart = null,
          child: Stack(
            fit: StackFit.expand,
            children: [
              RawImage(image: image, fit: BoxFit.contain),
              if (displayRect != null)
                Positioned.fromRect(
                  rect: displayRect,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color: Colors.blue.withValues(alpha: 0.15),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Offset _clampToImage(Offset local, Offset offset, double scale) {
    final image = _image!;
    return Offset(
      local.dx.clamp(offset.dx, offset.dx + image.width * scale),
      local.dy.clamp(offset.dy, offset.dy + image.height * scale),
    );
  }

  Rect _normalize(Rect rect) {
    return Rect.fromLTWH(
      rect.left.clamp(0.0, 1.0),
      rect.top.clamp(0.0, 1.0),
      rect.width.clamp(0.0, 1.0 - rect.left.clamp(0.0, 1.0)),
      rect.height.clamp(0.0, 1.0 - rect.top.clamp(0.0, 1.0)),
    );
  }
}
