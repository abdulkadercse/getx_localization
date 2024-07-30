import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/translations.dart';
import 'controller/language_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyTranslations.loadTranslations();

  final LanguageController languageController = Get.put(LanguageController());
  await languageController.loadLanguage(); // Load the saved language preference

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(),
      locale: Get.locale, // Use the loaded locale
      fallbackLocale: Locale('en', 'US'),
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  final languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'bn', 'name': 'Bangla'},
    {'code': 'ar', 'name': 'Arabic'}
  ];

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Localization Example'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello'.tr),
            SizedBox(height: 10),
            Text('welcome'.tr),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10,vertical: 2 ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(language['name']!),
                                Obx(() => Radio<String>(
                                      value: language['code']!,
                                      groupValue:
                                          languageController.selectedLanguageCode.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          languageController.changeLanguage(
                                              language['code']!, language['name']!);
                                        }
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
