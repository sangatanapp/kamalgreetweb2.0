import 'package:get/get.dart';

import 'EnglishStrings.dart';
import 'HindiStrings.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    ...EnglishStrings().keys,
    ...HindiStrings().keys,
  };
}
