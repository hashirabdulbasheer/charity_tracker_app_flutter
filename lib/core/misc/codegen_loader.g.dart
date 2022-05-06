// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "errors": {
    "create_charity_error": "Sorry, there was a problem saving the entry. Please try again later.",
    "update_charity_error": "Sorry, there was a problem updating the entry. Please try again later.",
    "deleting_charity_error": "Sorry, there was a problem deleting the entry. Please try again later.",
    "general_error": "Sorry, some error occurred. Please try again later."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
