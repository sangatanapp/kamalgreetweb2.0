import 'package:crop_your_image/crop_your_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/main.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:uuid/uuid.dart';

class CreationImageUploadViewModel extends GetxController {
  /// IMAGE OPERATIONS ---------------------------------------------------------
  void uploadPhoto(String photo) {
    imageVideoMainCtrl.mainPostImage.value = photo;
    update();
    imageVideoMainCtrl.isLoading.value = false;
  }

  void uploadToFirebase(Uint8List galleryImage) async {
    imageVideoMainCtrl.isLoading.value = true;
    Reference createRef(
        String bucket, String path, String datePath, String category) {
      return FirebaseStorage.instanceFor(bucket: bucket)
          .ref()
          .child(path)
          .child(datePath)
          .child(category);
    }

    String bucket;
    String path;
    String category = "all";
    String datePath = "";

    if (sanatanDashboardCtrl.isSanatan == true) {
      bucket = "kamal-konnect-lite.appspot.com";
      path = "test_sanatan/postContent";
    } else {
      if (dashboardCtrl.whichApp == "guruvani") {
        bucket = "postkaro-3dd61.appspot.com";
        path = "guruvani/content";
      } else if (dashboardCtrl.whichApp == "islamic") {
        bucket = "postkaro-3dd61.appspot.com";
        path = "islamic/content";
      } else if (dashboardCtrl.whichApp == "quran") {
        bucket = "postkaro-3dd61.appspot.com";
        path = "quran/content";
      }
      else {
        // if (dashCtr.languageShortName.value == 'hi' ||
        //     dashCtr.languageShortName.value == 'en') {
        //   bucket = "kamal-konnect-lite.appspot.com";
        // } else if (["kn", "te", "ta", "ml"]
        //     .contains(dashCtr.languageShortName.value)) {
        //   bucket = "karyakarta-connect.appspot.com";
        // } else if (["or", "bn"].contains(dashCtr.languageShortName.value)) {
        //   bucket = "kamal-konnect.firebasestorage.app";
        // } else {
        //   bucket = "post-karo-b0fe6.appspot.com";
        // }
        bucket = "post-karo-b0fe6.appspot.com";
        path = "postkarocard";

        // if ((tagController.fieldNameMapping.value.contains('political') &&
        //         tagController.selectedCategoryList.contains('frame')) ||
        //     tagController.selectedCategoryList.contains('frame')) {
        //   category = "frame";
        // } else if (tagController.fieldNameMapping.value.contains('political')) {
        //   category = "political";
        // }
      }
    }

    Reference ref = createRef(bucket, path, datePath, category);

    String id = const Uuid().v1();
    ref = ref.child(id);

    UploadTask uploadTask =
        ref.putData(galleryImage, SettableMetadata(contentType: 'image/webp'));
    TaskSnapshot snapshot = await uploadTask;
    imageVideoMainCtrl.firebaseImageUrl.value = await snapshot.ref.getDownloadURL();
    uploadPhoto(imageVideoMainCtrl.firebaseImageUrl.value);
    print("i am the firebase url -> ${imageVideoMainCtrl.firebaseImageUrl.value}");
    EasyLoading.dismiss();
  }

  void removeImage() {
    imageVideoMainCtrl.mainPostImage.value = '';
    update();
  }

  Future<void> pickImageFromGallery() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      ImagePicker picker = ImagePicker();
      XFile? file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (file != null) {
        Uint8List? imageBytes = await file.readAsBytes();
        if (imageBytes.length > 2048 * 2048) {
          EasyLoading.showError('Image size limit is 2 MB');
        } else {
          CropController controller = CropController();
          await cropCardImage(imageBytes, controller);
          EasyLoading.dismiss();
        }
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> cropCardImage(
      Uint8List imagePath, CropController controller) async {
    double getAspectRatio() {
      List<String> ratioParts = imageVideoMainCtrl.cropRatio.value.split(':');
      if (ratioParts.length == 2) {
        return double.parse(ratioParts[0]) / double.parse(ratioParts[1]);
      } else {
        return 1.0;
      }
    }

    return await showDialog(
      barrierDismissible: false,
      context: NavigationService.navigatorKey.currentContext!,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: 520,
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 450,
                      height: 450,
                      child: Crop(
                        image: imagePath,
                        controller: controller,
                        onCropped: (image) {
                          EasyLoading.dismiss();
                          return uploadToFirebase(imagePath);
                        },
                        aspectRatio: getAspectRatio(),
                        baseColor: Colors.teal.shade100,
                        maskColor: Colors.white.withAlpha(100),
                        progressIndicator: const CircularProgressIndicator(),
                        radius: 20,
                        onStatusChanged: (status) {},
                        cornerDotBuilder: (size, edgeAlignment) =>
                            const DotControl(color: Colors.blue),
                        clipBehavior: Clip.none,
                        interactive: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(NavigationService
                                  .navigatorKey.currentContext!);
                            }),
                        const SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                            child: const Text('Crop it!'),
                            onPressed: () async {
                              EasyLoading.show(
                                status: 'Cropping image...',
                              );

                              await Future.delayed(
                                  const Duration(milliseconds: 100));

                              controller.crop();

                              Navigator.pop(NavigationService
                                  .navigatorKey.currentContext!);
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void checkUint8ListSize(Uint8List image) {
    final sizeInBytes = image.length;
    final sizeInMB = sizeInBytes / (1024 * 1024); // Convert bytes to MB

    if (sizeInMB > 1) {
      EasyLoading.showError("File size exceeds 1 MB.");
      throw Exception(
          'File size exceeds 1 MB. Current size: ${sizeInMB.toStringAsFixed(2)} MB');
    } else {
      uploadToFirebase(image);
      print(
          'OK: File size is within the limit (${sizeInMB.toStringAsFixed(2)} MB).');
    }
  }
}
// void uploadToFirebase(Uint8List galleryImage) async {
//   postController.isLoading.value = true;
//
//   Reference ref;
//
//   if (dashboardCtrl.whichApp == "guruvani") {
//     ref = FirebaseStorage.instanceFor(bucket: "postkaro-3dd61.appspot.com")
//         .ref()
//         .child('guruvani')
//         .child("content")
//         .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//         .child("all");
//   } else if (dashboardCtrl.whichApp == "islamic") {
//     ref = FirebaseStorage.instanceFor(bucket: "postkaro-3dd61.appspot.com")
//         .ref()
//         .child('islamic')
//         .child("content")
//         .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//         .child("all");
//   } else {
//     if (dashCtr.languageShortName.value == 'hi' ||
//         dashCtr.languageShortName.value == 'en') {
//       ///en, hi
//       if ((tagController.fieldNameMapping.value.contains('political') &&
//               tagController.selectedCategoryList.contains('frame')) ||
//           (tagController.selectedCategoryList.contains('frame'))) {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "kamal-konnect-lite.appspot.com")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("frame");
//       } else if (tagController.fieldNameMapping.value.contains('political')) {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "kamal-konnect-lite.appspot.com")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("political");
//       } else {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "kamal-konnect-lite.appspot.com ")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("all");
//       }
//     } else if (dashCtr.languageShortName.value == 'kn' ||
//         dashCtr.languageShortName.value == 'te' ||
//         dashCtr.languageShortName.value == 'ta' ||
//         dashCtr.languageShortName.value == 'ml') {
//       ///kn, te, ta, ml
//       if ((tagController.fieldNameMapping.value.contains('political') &&
//               tagController.selectedCategoryList.contains('frame')) ||
//           (tagController.selectedCategoryList.contains('frame'))) {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "karyakarta-connect.appspot.com")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("frame");
//       } else if (tagController.fieldNameMapping.value.contains('political')) {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "karyakarta-connect.appspot.com")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("political");
//       } else {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "karyakarta-connect.appspot.com")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("all");
//       }
//     } else if (dashCtr.languageShortName.value == 'or' ||
//         dashCtr.languageShortName.value == 'bn') {
//       ///or, bn
//       if ((tagController.fieldNameMapping.value.contains('political') &&
//               tagController.selectedCategoryList.contains('frame')) ||
//           (tagController.selectedCategoryList.contains('frame'))) {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "kamal-konnect.firebasestorage.app ")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("frame");
//       } else if (tagController.fieldNameMapping.value.contains('political')) {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "kamal-konnect.firebasestorage.app ")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("political");
//       } else {
//         ref = FirebaseStorage.instanceFor(
//                 bucket: "kamal-konnect.firebasestorage.app ")
//             .ref()
//             .child('postkarocard')
//             .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//             .child("all");
//       }
//     } else {
//       /// PREVIOUS CODE below
//       if ((tagController.fieldNameMapping.value.contains('political') &&
//               tagController.selectedCategoryList.contains('frame')) ||
//           (tagController.selectedCategoryList.contains('frame'))) {
//         ref =
//             FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
//                 .ref()
//                 .child('postkarocard')
//                 .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//                 .child("frame");
//       } else if (tagController.fieldNameMapping.value.contains('political')) {
//         ref =
//             FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
//                 .ref()
//                 .child('postkarocard')
//                 .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//                 .child("political");
//       } else {
//         ref =
//             FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
//                 .ref()
//                 .child('postkarocard')
//                 .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
//                 .child("all");
//       }
//
//       /// PREVIOUS CODE above
//     }
//   }
//
//   String id = const Uuid().v1();
//   ref = ref.child(id);
//   UploadTask uploadTask =
//       ref.putData(galleryImage, SettableMetadata(contentType: 'image/jpeg'));
//   TaskSnapshot snapshot = await uploadTask;
//   postController.firebaseImageUrl.value = await snapshot.ref.getDownloadURL();
//   uploadPhoto(postController.firebaseImageUrl.value);
//   print("i am the firebase url -> ${postController.firebaseImageUrl.value}");
// }
