/// 内容寻址存储后的图片信息。
class StoredImage {
  const StoredImage({
    required this.sha256,
    required this.relPath,
    required this.bytes,
    required this.mime,
  });

  final String sha256;
  final String relPath;
  final int bytes;
  final String mime;
}
