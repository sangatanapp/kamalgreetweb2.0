import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/data/api/SanatanApi.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/data/model/SanatanPostModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class SanatanDashboardViewModel extends GetxController {
  bool? isSanatan;

  RxInt selectedModule = 0.obs;
  List moduleName = ["Post", "Wallpaper", "Mantra", "Darshan"];

  RxList<SanatanPostData> sanatanPostList = <SanatanPostData>[].obs;

  final api = SanatanApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  final rxSanatanPostStatus = Status.INITIAL.obs;
  final ScrollController scrollController = ScrollController();
  RxString filterType = "ONGOING".obs;
  RxString categorySelected = 'post'.obs;
  RxSet<String> selectedCategoryList = <String>{}.obs;



  toggleOngoingFilter(String val) {
    filterType.value = val;
    filterType.refresh();
  }

  void setRxSanatanPostStatus(Status value) =>
      rxSanatanPostStatus.value = value;

  Future getSanatanPost() async {
    setRxSanatanPostStatus(Status.LOADING);

    final res = filterType.value == "ONGOING"
        ? await api.getSanatanPost("Bearer ${GreetStorage.getAuthToken()!}")
        : await api
            .getSanatanUpcomingPost("Bearer ${GreetStorage.getAuthToken()!}");
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

  clearCategory() {
    selectedCategoryList.clear();
    update();
  }
}
