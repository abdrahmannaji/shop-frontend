import 'package:flutter/material.dart';
import 'package:mobailshop/localization/app_localization.dart';

getTranslated(String key, BuildContext context) {
  return AppLocalization.of(context)!.translate(key);
}
