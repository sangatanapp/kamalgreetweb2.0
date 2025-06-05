import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/webp/models/image_data.dart';
import 'dart:html' as html;

import 'package:kamal_greet_web_2/webp/services/image_converter_service.dart';

class ImageConverterViewModel extends GetxController {
  final ImageConverterService _service = ImageConverterService();

  ImageData? _imageData;
  bool _isLoading = false;
  String? _error;
  Uint8List? _webpImageBytes;

  ImageData? get imageData => _imageData;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Uint8List? get webpImageBytes => _webpImageBytes;

  Future<void> pickAndConvertImage({bool isFromPoojaWallpaper = false}) async {
    EasyLoading.show(status: "Uploading Photo", dismissOnTap: false);
    if (!kIsWeb) {
      _error = 'This feature is only available on web';
      return;
    }

    try {
      _isLoading = true;
      _error = null;

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'WebP'],
        allowMultiple: true,
      );

      if (result == null || result.files.isEmpty) {
        EasyLoading.showError("No image selected");
        throw Exception('No image selected');
      }

      final file = result.files.first;
      if (file.bytes == null) {
        EasyLoading.showError("Failed to read image data");
        throw Exception('Failed to read image data');
      }
      for (var file in result.files) {
        final fileBytes = file.bytes;
        final fileName = file.name;

        if (fileBytes != null) {
          // Create an HTML image element to read the dimensions
          final blob = html.Blob([fileBytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);

          final image = html.ImageElement();
          image.src = url;

          image.onLoad.listen((event) async {
            final width = image.width;
            final height = image.height;
            final aspectRatio = width! / height!;

            if (aspectRatio.floor() != 1 && isFromPoojaWallpaper == false) {
              EasyLoading.showError(
                  "Please upload image with 1:1 aspect ratio only");
              throw Exception("Not valid ration");
            } else {
              _imageData = await _service.convertToWebP(
                file.bytes!,
                file.name,
              );
              _webpImageBytes = _imageData!.webpImage;
            }

            print('File: $fileName');
            print('Width: $width, Height: $height, Aspect Ratio: $aspectRatio');

            // Cleanup the object URL
            html.Url.revokeObjectUrl(url);
          });

          image.onError.listen((event) {
            print('Error loading image: $fileName');
          });
        }
      }
    } catch (e) {
      _error = e.toString();
      _imageData = null;
    } finally {
      _isLoading = false;
    }
  }
}
