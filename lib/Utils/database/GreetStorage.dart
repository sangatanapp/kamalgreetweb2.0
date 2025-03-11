import 'package:get_storage/get_storage.dart';

class GreetStorage {
  static String userInfoKey = "identification_token";
  static String idKey = "card_id";
  static String titleKey = "titleKey";
  static String contentKey = "contentKey";
  static String startDateKey = "startDateKey";
  static String endDateKey = "endDateKey";
  static String tagListKey = "tagListKey";
  static String photoKey = "photoKey";
  static String optionKey = "optionKey";
  static String shapeKey = "shapeKey";
  static String colorKey = "colorKey";
  static GetStorage storage = GetStorage();

  static setUserIdentificationToken(String token) async {
    await storage.write(userInfoKey, token);
  }

  static String? getUserIdentificationToken() {
    return storage.read(userInfoKey);
  }

  static setAuthToken(String token) async {
    await storage.write(userInfoKey, token);
  }

  static String? getAuthToken() {
    return storage.read(userInfoKey);
  }

  static setId(String id) async {
    await storage.write(idKey, id);
  }

  static String? getId() {
    return storage.read(idKey);
  }

  static setOption(String option) async {
    await storage.write(optionKey, option);
  }

  static String? getOption() {
    return storage.read(optionKey);
  }

  static setShape(String shape) async {
    await storage.write(shapeKey, shape);
  }

  static String? getShape() {
    return storage.read(shapeKey);
  }

  static setColor(String color) async {
    await storage.write(colorKey, color);
  }

  static String? getColor() {
    return storage.read(colorKey);
  }

  static setTitle(String title) async {
    await storage.write(titleKey, title);
  }

  static String? getTitle() {
    return storage.read(titleKey);
  }

  static setSharingContent(String content) async {
    await storage.write(contentKey, content);
  }

  static String? getSharingContent() {
    return storage.read(contentKey);
  }

  static setStartDate(String startDate) async {
    await storage.write(startDateKey, startDate);
  }

  static String? getStartDate() {
    return storage.read(startDateKey);
  }

  static setPhoto(String photo) async {
    await storage.write(photoKey, photo);
  }

  static String? getPhoto() {
    return storage.read(photoKey);
  }

  static setEndDate(String endDate) async {
    await storage.write(endDateKey, endDate);
  }

  static String? getEndDate() {
    return storage.read(endDateKey);
  }

  static setTagList(List<String> tagList) async {
    await storage.write(tagListKey, tagList);
  }

  static List<String>? getTagList() {
    return storage.read(tagListKey);
  }

  static removeUserIdentificationToken() async {
    await storage.remove(userInfoKey);
    storage.erase();
  }

  static cleanAllLocalStorage() {
    storage.erase();
  }
}
