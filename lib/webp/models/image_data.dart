import 'dart:typed_data';

class ImageData {
  final String fileName;
  final int originalSize;
  String? webpUrl;
  int? convertedSize;
  Uint8List? webpImage;

  ImageData({
    required this.fileName,
    required this.originalSize,
    this.webpUrl,
    this.convertedSize,
    this.webpImage,
  });
}
