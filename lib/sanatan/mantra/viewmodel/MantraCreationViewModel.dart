import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/mantra/data/api/MantraApi.dart';
import 'package:kamal_greet_web_2/sanatan/mantra/data/model/MantraModel.dart';

class MantraViewModel extends GetxController {
  Rx<TextEditingController> mantraTitleCtrl = TextEditingController().obs;
  Rx<TextEditingController> mantraDescCtrl = TextEditingController().obs;
  RxList<MantraListData> mantraList = <MantraListData>[].obs;
  String firebaseAudioUrl = "";

  final api = MantraApi(apiCallBaseOption());

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

}
