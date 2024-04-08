// @dart=2.9
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tut_application/app/di.dart';
import 'package:tut_application/presentation/resources/language_manager.dart';
import 'app/app.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
void main() async {
  GestureBinding.instance?.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();   // TO REMOVE NULL ERROR
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: [ENGLISH_LOCAL, ARABIC_LOCAL],
    path: ASSETS_PATH_LOCALISATIONS,
    child: Phoenix(child: MyApp()),
  ));
}