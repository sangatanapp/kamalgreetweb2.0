// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kamalgreet/Creation/bunny-cdn/bunny-cdn-service.dart';
// import 'package:kamalgreet/Creation/viewModel/CreationViewModel.dart';
// import 'package:uuid/uuid.dart';
// import 'dart:html' as html;
//
// class CreationVideoUploadViewModel extends GetxController {
//   /// VIDEO TO FIREBASE --------------------------------------------------------
//
//   late PlatformFile file;
//   final BunnyCDNService _bunnyCDNService = BunnyCDNService();
//
//   Future<void> pickVideoFromGallery() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['mp4', 'webm'],
//         withData: true,
//       );
//
//       if (result != null && result.files.single.bytes != null) {
//         file = result.files.first;
//
//         final videoFile = html.Blob([result.files.single.bytes!], 'video/*');
//         final videoUrl = html.Url.createObjectUrlFromBlob(videoFile);
//         postController.selectedVideoPath.value = videoUrl;
//         loadVideo(videoUrl);
//         postController.videoPathForFirebase = result.files.single.bytes!;
//       }
//     } catch (e) {
//       print('ERROR => ${e.toString()}');
//     }
//   }
//
//   // Future<void> videoToFirebase() async {
//   //   try {
//   //     String fileName =
//   //         "video/postKaroVideo-${postController.endDateString.value}-${const Uuid().v1()}.${file.extension}";
//   //
//   //     Map<String, dynamic> uploadResult =
//   //         await _bunnyCDNService.uploadVideo(file, fileName);
//   //
//   //     if (uploadResult['success']) {
//   //       String videoUrl = _bunnyCDNService.getVideoUrl(fileName);
//   //       postController.videoFirebaseUrl.value = videoUrl;
//   //       print('Video URL from bunny: $videoUrl');
//   //       print(
//   //           "Video uploaded successfully: ${postController.videoFirebaseUrl.value}");
//   //     } else {
//   //       postController.videoFirebaseUrl.value = "";
//   //       print("Video not uploaded: ${postController.videoFirebaseUrl.value}");
//   //     }
//   //   } catch (e) {
//   //     print("Error uploading video to bunny: $e");
//   //   }
//   // }
//   Future<void> videoToFirebase(Uint8List videoBytes) async {
//     EasyLoading.showInfo("Uploading Video");
//     try {
//       Reference ref =
//           FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
//               .ref()
//               .child('postKaroVideo')
//               .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//               .child(const Uuid().v1());
//
//       UploadTask uploadTask = ref.putData(
//         videoBytes,
//         SettableMetadata(
//             contentType: 'video/mp4'), // Correct content type for video
//       );
//
//       TaskSnapshot snapshot = await uploadTask;
//
//       postController.videoFirebaseUrl.value =
//           await snapshot.ref.getDownloadURL();
//       EasyLoading.showInfo("Video uploaded successfully");
//
//       print(
//           "Video uploaded successfully: ${postController.videoFirebaseUrl.value}");
//     } catch (e) {
//       print("Error uploading video to Firebase: $e");
//     }
//   }
//
//   Future<String> thumbnailToFirebase(String galleryImage) async {
//     try {
//       Uint8List imageData =
//           base64ToUint8List(postController.mainPostImage.value!);
//
//       Reference ref =
//           FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
//               .ref()
//               .child('postKaroVideo')
//               .child("thumbnail")
//               .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//               .child(const Uuid().v1());
//       String id = const Uuid().v1();
//       ref = ref.child(id);
//       UploadTask uploadTask =
//           ref.putData(imageData, SettableMetadata(contentType: 'image/png'));
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       return '';
//     }
//   }
//
//   Uint8List base64ToUint8List(String base64String) {
//     final base64Data = base64String.split(',').last;
//     return base64.decode(base64Data);
//   }
//
//   void loadVideo(String videoSrc) {
//     final videoElement = html.VideoElement();
//     videoElement.src = videoSrc;
//
//     videoElement.onLoadedMetadata.listen((event) {
//       postController.videoHeight.value = videoElement.videoHeight.toDouble();
//       postController.videoWidth.value = videoElement.videoWidth.toDouble();
//
//       if (postController.videoWidth.value != null &&
//           postController.videoHeight.value != null &&
//           postController.videoHeight.value != 0) {
//         postController.videoRatio.value = (postController.videoWidth.value! /
//                 postController.videoHeight.value!)
//             .toStringAsFixed(3);
//       }
//
//       videoElement.currentTime = 1;
//       videoElement.onSeeked.listen((_) {
//         final canvas = html.CanvasElement(
//             width: postController.videoWidth.value!.toInt(),
//             height: postController.videoHeight.value!.toInt());
//         final ctx = canvas.context2D;
//         ctx.drawImage(videoElement, 0, 0);
//
//         postController.mainPostImage.value = canvas.toDataUrl();
//       });
//     });
//
//     videoElement.load();
//   }
// }
