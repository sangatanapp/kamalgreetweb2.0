import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniDashboard.dart';
import 'package:uuid/uuid.dart';

class LogoPickerViewModel extends GetxController {
  RxBool logoLoading = false.obs;
  RxString firebaseImageUrl = "".obs;
  RxBool isLoadingLogo = false.obs;
  RxString logoPhoto = ''.obs;

  Future<void> pickLogo(
      {required bool isFromGuruVani,
      required bool isFromSanatanGod,
      required bool isFromPoojaThumbnail}) async {
    logoLoading.value = true;
    ImagePicker picker = ImagePicker();
    XFile? file =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);

    if (file != null) {
      Uint8List? bytes = await file.readAsBytes();
      await uploadLogo(
          bytes, isFromGuruVani, isFromSanatanGod, isFromPoojaThumbnail);
    }
    logoLoading.value = false;
  }

  Future<void> uploadLogo(Uint8List galleryImage, bool isFromGuruVani,
      bool isFromSanatanGod, bool isFromPoojaThumbnail) async {
    isLoadingLogo.value = true;
    Reference ref = isFromGuruVani
        ? FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
            .ref()
            .child('GuruVani')
            .child('guruImage')
        : isFromSanatanGod
            ? FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
                .ref()
                .child('Sanatan')
                .child('godPhoto')
            : FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
                .ref()
                .child('partyLogo');
    String id = const Uuid().v1();
    ref = ref.child(id);
    UploadTask uploadTask =
        ref.putData(galleryImage, SettableMetadata(contentType: 'image/jpeg'));
    TaskSnapshot snapshot = await uploadTask;
    firebaseImageUrl.value = await snapshot.ref.getDownloadURL();
    isFromGuruVani
        ? guruCtrl.uploadGuruPhoto(firebaseImageUrl.value)
        // : isFromSanatanGod
        //     ? sanatanGodCtrl.uploadGodPhoto(firebaseImageUrl.value)
        //     : isFromPoojaThumbnail
        //         ? poojaDashboardCtrl
        //             .uploadPoojaThumbnail(firebaseImageUrl.value)
        : uploadLogoPhoto(firebaseImageUrl.value);
  }

  void uploadLogoPhoto(String photo) {
    logoPhoto.value = photo;
    update();
    isLoadingLogo.value = false;
  }
}
