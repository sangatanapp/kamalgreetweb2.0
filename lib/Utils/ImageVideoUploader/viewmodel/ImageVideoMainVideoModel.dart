

import 'package:get/get.dart';

class ImageVideoMainVideoModel extends GetxController{

  RxString mainPostImage = ''.obs;
  RxString videoFirebaseUrl = ''.obs;
  RxBool isLoading = false.obs;
  RxString firebaseImageUrl = "".obs;
  RxString cropRatio = "".obs;
  RxString videoRatio = '1'.obs;
  RxString selectedShape = 'square'.obs;
  RxString selectedAlignment = 'bottomLeft'.obs;



  /// OTHER OPERATIONS ---------------------------------------------------------
  void selectOption(String option) {
    selectedAlignment.value = option;
  }

  void selectVideoAvtarShapeOption(String option) {
    selectedShape.value = option;
  }



}