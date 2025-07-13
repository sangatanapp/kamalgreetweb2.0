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
import 'package:kamal_greet_web_2/sanatan/sangrah/mantra/data/api/MantraApi.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/mantra/data/model/MantraModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uuid/uuid.dart';

import '../../../../Utils/widgets/DynamicAppbar.dart';

class MantraViewModel extends GetxController {
  Rx<TextEditingController> mantraTitleCtrl = TextEditingController().obs;
  Rx<TextEditingController> mantraDescCtrl = TextEditingController().obs;
  RxList<MantraListData> mantraList = <MantraListData>[].obs;
  String firebaseAudioUrl = "";
  List sangrahModuleName = ["Mantra", "Aarti", "chaleesa", "Stōtra","Ring/Msg Tone"];
  RxInt sangrahSelectedModule = 0.obs;

  final api = MantraApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  final rxMantraStatus = Status.INITIAL.obs;

  void setRxMantraStatus(Status value) => rxMantraStatus.value = value;

  Future createMantra() async {
    EasyLoading.show();

    final res =
        await api.createMantra("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": mantraTitleCtrl.value.text,
      "description": mantraDescCtrl.value.text,
      "audio_link": firebaseAudioUrl,
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString()
    });
    try {
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("Mantra Added");
        getMantra();
        Get.back();
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {}
  }

  Future getMantra() async {
    setRxMantraStatus(Status.LOADING);
    final res = await api.getMantra("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        MantraModel model = MantraModel.fromJson(res.data);
        mantraList.value = model.data ?? [];
        mantraList.value = mantraList.reversed.toList();
        mantraList.refresh();
        setRxMantraStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxMantraStatus(Status.ERROR);
      }
    } catch (e) {
      setRxMantraStatus(Status.ERROR);
    }
  }

  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting Mantra...");

    final res =
        await api.deleteMantra("Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Card Deleted Successfully!");
        await getMantra();
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
    firebaseAudioUrl = await snapshot.ref.getDownloadURL();
    print("i am the firebase url -> $firebaseAudioUrl");
    EasyLoading.dismiss();
  }
}
