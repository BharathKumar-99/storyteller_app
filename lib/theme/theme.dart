import 'package:flutter/material.dart';
import 'package:storyteller/theme/pallet.dart';

import '../helpers/theme_helper.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: generateMaterialColor(ColorPallet.primary),
  fontFamily: 'inter',
  textTheme: lightTextTheme,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    hintStyle: lightTextTheme.bodyLarge?.copyWith(color: Colors.grey),
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  scaffoldBackgroundColor: ColorPallet.background,
  elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: WidgetStatePropertyAll(2),
          padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: ColorPallet.accent, width: 1.5)),
          ),
          foregroundColor: WidgetStatePropertyAll(ColorPallet.onPrimary),
          backgroundColor: WidgetStatePropertyAll(ColorPallet.accent))),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: ColorPallet.primary,
    secondary: ColorPallet.secondary,
    onSecondary: ColorPallet.onSecondary,
    onPrimary: ColorPallet.onPrimary,
    surface: ColorPallet.background,
    tertiary: ColorPallet.accent,
    onTertiary: ColorPallet.onSecondary,
    onSurface: ColorPallet.black,
  ),
);

TextTheme lightTextTheme = const TextTheme(
  displayLarge: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  ),
  displayMedium: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  ),
  displaySmall: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  ),
  headlineLarge: TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.w700, color: ColorPallet.primary),
  headlineMedium: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  ),
  headlineSmall: TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
  ),
  titleLarge: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ),
  titleMedium: TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
  ),
  titleSmall: TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
  ),
  bodyLarge: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  ),
  labelMedium: TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  ),
  labelSmall: TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  ),
);
