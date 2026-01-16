import 'package:flutter/material.dart';
import 'package:wedding/core/themes/custom_colors.dart';
import 'package:wedding/shared/constants/radius_values.dart';

class Themes {
  static final Color darkBrown = CustomColors.primary;

  static final ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Raleway",

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
      surfaceBright: CustomColors.dropdown,
      surfaceDim: CustomColors.textPrimary,
      shadow: CustomColors.cardBorder,
    ),

    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: CustomColors.background,

    // TEXT THEME (globale Raleway)
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 50, fontWeight: FontWeight.w300, color: CustomColors.textPrimary),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: CustomColors.textPrimary),
      titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: CustomColors.textPrimary),
      titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: CustomColors.textPrimary),
      titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: CustomColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CustomColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: CustomColors.textPrimary),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: CustomColors.textPrimary),
    ),

    // FORM GLOBAL STYLE
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CustomColors.card.withValues(alpha: 0.3),
      hintStyle: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w400, fontSize: 12, color: CustomColors.textSecondary),
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
        fontFamily: "Raleway",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: CustomColors.textPrimary.withValues(alpha: 0.8),
      ),
    ),

    // RADIO BUTTON THEME
    radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(darkBrown)),

    // ELEVATED BUTTON THEME (GLOBAL)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBrown,
        foregroundColor: Colors.white,

        // altezza/padding uniforme
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),

        // font coerente con il tema
        textStyle: const TextStyle(fontFamily: 'Raleway', fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),

        // bordi coerenti con i tuoi input
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusValues.r20)),

        // profondità coerente
        elevation: 3,
      ),
    ),

    // DROPDOWN STYLE GLOBALE
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w400, fontSize: 12, color: CustomColors.textPrimary),
      menuStyle: MenuStyle(
        // Questo cambia lo sfondo del menu a tendina quando è aperto
        backgroundColor: WidgetStatePropertyAll(CustomColors.dropdown),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent), // Evita riflessi violacei in Material 3
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusValues.r20),
            side: BorderSide(color: CustomColors.cardBorder.withValues(alpha: 0.8), width: 0.1),
          ),
        ),
      ),
    ),
  );
}
