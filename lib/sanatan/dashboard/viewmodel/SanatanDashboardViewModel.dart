import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/data/api/SanatanApi.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/data/model/SanatanPostModel.dart';

class SanatanDashboardViewModel extends GetxController {
  bool? isSanatan;

  RxInt selectedModule = 0.obs;
  List moduleName = ["Post", "Wallpaper", "Mantra", "Darshan"];

  RxList<SanatanPostData> sanatanPostList = <SanatanPostData>[].obs;

  final api = SanatanApi(apiCallBaseOption());

  final rxSanatanPostStatus = Status.INITIAL.obs;

  void setRxSanatanPostStatus(Status value) =>
      rxSanatanPostStatus.value = value;

  Future getSanatanPost() async {
    setRxSanatanPostStatus(Status.LOADING);
    final res =
        await api.getSanatanPost("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        SanatanPostModel model = SanatanPostModel.fromJson(res.data);
        sanatanPostList.value = model.data ?? [];
        sanatanPostList.value = sanatanPostList.reversed.toList();
        sanatanPostList.refresh();
        setRxSanatanPostStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxSanatanPostStatus(Status.ERROR);
      }
    } catch (e) {
      setRxSanatanPostStatus(Status.ERROR);
    }
  }

  Flexible rowMaker(List<Widget> child, bool isMobile) {
    return Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: child,
    ));
  }

  Align richTextMaker(
      IconData iconName, String titlePrefix, String title, bool isMobile) {
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
                        text: '$titlePrefix: ',
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
