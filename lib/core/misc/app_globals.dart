import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'di_container.dart';

class CharityGlobals {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    CharityDIContainer.init();
  }
}
