import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import 'colors/custom_colors_extension.dart';
import 'typography/custom_text_styles.dart';

/// Bileşen temalarını Furio'nun tema renkleriyle oluşturur.
abstract final class CustomWidgetThemes {
  static SliderThemeData slider(CustomColorsExtension colors) =>
      SliderThemeData(
        trackHeight: 4,
        activeTrackColor: colors.primary,
        inactiveTrackColor: colors.border,
        thumbColor: colors.primary,
        overlayColor: colors.primary.withValues(alpha: 0.12),
        disabledActiveTrackColor: colors.disabled,
        disabledInactiveTrackColor: colors.border,
        disabledThumbColor: colors.disabled,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      );

  static SwitchThemeData switchTheme(CustomColorsExtension colors) =>
      SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? colors.surface
              : Colors.white,
        ),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return colors.border;
          return states.contains(WidgetState.selected)
              ? colors.primary
              : colors.border;
        }),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
        trackOutlineWidth: const WidgetStatePropertyAll(0),
        // Boş ikon, düğmenin boyutunu iki durumda da sabit tutar.
        thumbIcon: const WidgetStatePropertyAll(Icon(null)),
      );

  static ChipThemeData chip(CustomColorsExtension colors) => ChipThemeData(
    color: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return colors.border;
      return states.contains(WidgetState.selected)
          ? colors.primary.withValues(alpha: 0.10)
          : colors.surface;
    }),
    labelStyle: CustomTextStyles(colors).size14(color: colors.textSecondary),
    secondaryLabelStyle: CustomTextStyles(colors)
        .size14(color: colors.primary, weight: FontWeight.w600),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
    showCheckmark: false,
    elevation: 0,
    pressElevation: 0,
    surfaceTintColor: Colors.transparent,
  );

  static BottomSheetThemeData bottomSheet(CustomColorsExtension colors) =>
      BottomSheetThemeData(
        backgroundColor: colors.surfaceSheet,
        modalBackgroundColor: colors.surfaceSheet,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        clipBehavior: Clip.antiAlias,
      );

  static TextTheme textTheme(CustomColorsExtension colors) => TextTheme(
    displaySmall: CustomTextStyles(colors).size28(weight: FontWeight.w700),
    headlineMedium: CustomTextStyles(colors).size26(weight: FontWeight.w700),
    titleLarge: CustomTextStyles(colors).size21(weight: FontWeight.w600),
    titleMedium: CustomTextStyles(colors).size18(weight: FontWeight.w600),
    bodyLarge: CustomTextStyles(colors).size16(),
    bodyMedium: CustomTextStyles(colors).size14(),
    bodySmall: CustomTextStyles(colors).size12(color: colors.textSecondary),
    labelLarge: CustomTextStyles(colors).size15(weight: FontWeight.w600),
  );

  static FilledButtonThemeData filledButton(CustomColorsExtension colors) =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: CustomTextStyles(colors).size15(weight: FontWeight.w600),
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.disabled,
          disabledForegroundColor: colors.border,
        ),
      );

  static AppBarThemeData appBar(
    CustomColorsExtension colors, {
    required Brightness brightness,
  }) => AppBarThemeData(
    systemOverlayStyle: brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark,
    backgroundColor: colors.card,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: CustomTextStyles(colors).size21(),
    elevation: 0,
    scrolledUnderElevation: 0,
    toolbarHeight: 64,
    titleSpacing: 16,
  );

  /// Varsayılan [TabAlignment.start] kaydırılabilir sekmeler içindir.
  static TabBarThemeData tabBar(
    CustomColorsExtension colors, {
    TabAlignment? tabAlignment = TabAlignment.start,
  }) => TabBarThemeData(
    tabAlignment: tabAlignment,
    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    labelColor: colors.primary,
    unselectedLabelColor: colors.textSecondary,
    labelStyle: CustomTextStyles(colors).size14(weight: FontWeight.w600),
    unselectedLabelStyle: CustomTextStyles(colors).size14(),
    indicatorColor: colors.primary,
    dividerColor: colors.border,
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed) ? Colors.transparent : null,
    ),
  );
}
