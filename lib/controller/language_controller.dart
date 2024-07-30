import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageController extends GetxController {
  final String _languageCodeKey = 'language_code';
  final String _languageNameKey = 'language_name';

  var selectedLanguageCode = ''.obs;
  var selectedLanguageName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  // Load the preferred language
  Future<void> loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(_languageCodeKey);
    String? languageName = prefs.getString(_languageNameKey);

    if (languageCode != null) {
      Get.updateLocale(Locale(languageCode));
      selectedLanguageCode.value = languageCode;
      selectedLanguageName.value = languageName ?? '';
    } else {
      Get.updateLocale(Locale('en', 'US')); // Default language
      selectedLanguageCode.value = 'en';
      selectedLanguageName.value = 'English'; // Default language name
    }
  }

  // Change the language and save preference
  Future<void> changeLanguage(String languageCode, String languageName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, languageCode);
    await prefs.setString(_languageNameKey, languageName);
    selectedLanguageCode.value = languageCode;
    selectedLanguageName.value = languageName;
    Get.updateLocale(Locale(languageCode));
  }
}
