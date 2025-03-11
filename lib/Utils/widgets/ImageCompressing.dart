import 'dart:html' as html; // Import for web file handling
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCompressing extends StatefulWidget {
  @override
  _ImageCompressingState createState() => _ImageCompressingState();
}

class _ImageCompressingState extends State<ImageCompressing> {
  Uint8List? _selectedImage;
  Uint8List? _compressedImage;
  double? _originalSize;
  double? _compressedSize;

  final ImagePicker _picker = ImagePicker();

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List fileBytes = await pickedFile.readAsBytes();

      // Calculate original size
      double originalFileSize = fileBytes.lengthInBytes / (1024 * 1024);

      setState(() {
        _selectedImage = fileBytes;
        _originalSize = originalFileSize;
      });

      // Compress the image
      await _compressImage(fileBytes);
    }
  }

  // Compress the image
  Future<void> _compressImage(Uint8List fileBytes) async {
    // Simulate compression by resizing the image
    Uint8List compressedBytes = Uint8List.fromList(fileBytes.sublist(0, (fileBytes.lengthInBytes * 0.5).toInt()));

    // Calculate compressed size
    double compressedFileSize = compressedBytes.lengthInBytes / (1024 * 1024);

    setState(() {
      _compressedImage = compressedBytes;
      _compressedSize = compressedFileSize;
    });

    // Trigger download
    _downloadCompressedImage(compressedBytes);
  }

  // Trigger download of the compressed image
  void _downloadCompressedImage(Uint8List compressedBytes) {
    final blob = html.Blob([compressedBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement()
      ..href = url
      ..download = "compressed_image_${DateTime.now().millisecondsSinceEpoch}.jpg"
      ..click();

    html.Url.revokeObjectUrl(url); // Revoke the object URL to free resources
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Compressing for Web'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Take Picture from Gallery'),
            ),
            if (_selectedImage != null)
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text('Original Size: ${_originalSize?.toStringAsFixed(2) ?? 'N/A'} MB'),
                  const SizedBox(height: 8),
                  if (_compressedSize != null)
                    Text('Compressed Size: ${_compressedSize?.toStringAsFixed(2) ?? 'N/A'} MB'),
                  const SizedBox(height: 16),
                  if (_compressedImage != null)
                    Image.memory(_compressedImage!, height: 200),
                ],
              ),
          ],
        ),
      ),
    );
  }
}