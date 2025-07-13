import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/ringtone/data/api/RingtoneApi.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/ringtone/data/model/RingtoneModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uuid/uuid.dart';

import '../../../../Utils/widgets/DynamicAppbar.dart';

class RingtoneViewModel extends GetxController {
  Rx<TextEditingController> ringtoneTitleCtrl = TextEditingController().obs;
  Rx<TextEditingController> ringtoneDescCtrl = TextEditingController().obs;
  RxList<RingtoneListData> ringtoneList = <RingtoneListData>[].obs;
  RxString firebaseAudioUrl = "".obs;
  RxInt selectedTone = 0.obs;
  List sangrahModuleName = [
    "Mantra",
    "Aarti",
    "chaleesa",
    "Stōtra",
    "Ringtone/MessageTone"
  ];
  RxInt sangrahSelectedModule = 0.obs;

  final api = RingtoneApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  final rxRingtoneStatus = Status.INITIAL.obs;

  void setRxRingtoneStatus(Status value) => rxRingtoneStatus.value = value;

  Future createRingtone() async {
    EasyLoading.show();

    final res =
        await api.createRingtone("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": ringtoneTitleCtrl.value.text,
      "description": ringtoneDescCtrl.value.text,
      "audio_link": firebaseAudioUrl.value,
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString(),
      "is_messagetone": selectedTone.value == 0 ? false : true
    });
    try {
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("Ringtone Added");
        getRingtone();
        Get.back();
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {}
  }

  Future getRingtone() async {
    setRxRingtoneStatus(Status.LOADING);
    final res = await api.getRingtone("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        RingtoneModel model = RingtoneModel.fromJson(res.data);
        ringtoneList.value = model.postData ?? [];
        ringtoneList.value = ringtoneList.reversed.toList();
        ringtoneList.refresh();
        setRxRingtoneStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxRingtoneStatus(Status.ERROR);
      }
    } catch (e) {
      setRxRingtoneStatus(Status.ERROR);
    }
  }

  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting Mantra...");

    final res =
        await api.deleteRingtone("Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Ringtone Deleted Successfully!");
        await getRingtone();
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Align richTextMaker(
      {required IconData iconName,
      required String titlePrefix,
      required String title,
      required bool isMobile}) {
    return Align(
      alignment: Alignment.centerLeft, // Align the Container to the left
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // Make Row only as wide as its content
            children: [
              Icon(
                iconName,
                size: isMobile ? 14 : 18,
                color: Colors.grey.withOpacity(0.6),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${titlePrefix}: ',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ),
                      TextSpan(
                        text: title,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickAndUploadAudio() async {
    EasyLoading.show(dismissOnTap: false);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      uploadAudio(fileBytes!);
    } else {
      EasyLoading.dismiss();
    }
  }

  void uploadAudio(Uint8List file) async {
    Reference createRef(String bucket, String path) =>
        FirebaseStorage.instanceFor(bucket: bucket).ref().child(path);

    Reference ref =
        createRef("kamal-konnect-lite.appspot.com", "sanatan/mantra");
    String id = "${const Uuid().v1()}.mp3";
    ref = ref.child(id);
    UploadTask uploadTask =
        ref.putData(file, SettableMetadata(contentType: 'audio/mpeg'));
    TaskSnapshot snapshot = await uploadTask;
    firebaseAudioUrl.value = await snapshot.ref.getDownloadURL();
    firebaseAudioUrl.refresh();
    print("i am the firebase url -> $firebaseAudioUrl");
    EasyLoading.dismiss();
  }
}
