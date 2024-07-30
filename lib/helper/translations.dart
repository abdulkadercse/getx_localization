import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MyTranslations extends Translations {
  static Map<String, Map<String, String>> translations = {};

  static Future<void> loadTranslations() async {
    final enJson = await rootBundle.loadString('assets/local/en.json');
    final bnJson = await rootBundle.loadString('assets/local/bn.json');
    final arJson = await rootBundle.loadString('assets/local/ar.json');

    translations['en'] = Map<String, String>.from(json.decode(enJson));
    translations['bn'] = Map<String, String>.from(json.decode(bnJson));
    translations['ar'] = Map<String, String>.from(json.decode(arJson));
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}
