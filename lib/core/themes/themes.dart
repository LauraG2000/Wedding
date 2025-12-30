import 'package:flutter/material.dart';
import 'package:joyflo_project/core/themes/custom_colors.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';

class Themes {
  static final Color darkBrown = CustomColors.primary;

  static final ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: CustomColors.primary,
      onPrimary: CustomColors.iconAddBg,
      secondary: CustomColors.textSecondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: CustomColors.textError,
      onSurface: CustomColors.background,
      surfaceContainerHighest: CustomColors.iconAdd,
      surface: CustomColors.card,
      surfaceDim: CustomColors.textPrimary,
      shadow: CustomColors.cardBorder,
    ),

    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: CustomColors.background,

    // TEXT THEME (globale Poppins)
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: CustomColors.textPrimary),
      titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: CustomColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CustomColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CustomColors.textPrimary),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: CustomColors.textPrimary),
    ),

    // FORM GLOBAL STYLE
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CustomColors.card.withValues(alpha: 0.3),
      hintStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w400, fontSize: 12, color: CustomColors.textSecondary),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r20),
        borderSide: BorderSide(color: CustomColors.cardBorder.withValues(alpha: 0.8), width: 0.1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r20),
        borderSide: BorderSide(color: CustomColors.cardBorder.withValues(alpha: 0.8), width: 0.1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r20),
        borderSide: BorderSide(color: darkBrown, width: 2),
      ),
      labelStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: CustomColors.textPrimary.withValues(alpha: 0.8),
      ),
    ),

    // RADIO BUTTON THEME
    radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(darkBrown)),

    // ELEVATED BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: darkBrown, foregroundColor: Colors.white),
    ),

    // DROPDOWN STYLE GLOBALE
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w400, fontSize: 12, color: CustomColors.textPrimary),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll(CustomColors.card),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusValues.r20),
            side: BorderSide(color: CustomColors.cardBorder.withOpacity(0.8), width: 0.1),
          ),
        ),
      ),
    ),
  );
}
