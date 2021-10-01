import 'package:flutter/material.dart';

import 'resources/colors_res.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: ColorsRes.fromHex(ColorsRes.primaryColor),
    scaffoldBackgroundColor: ColorsRes.fromHex(ColorsRes.whiteColor),
    appBarTheme: AppBarTheme(
      color: ColorsRes.fromHex(ColorsRes.primaryColor)
    ),
  );
}