import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import 'colors/furio_colors_extension.dart';
import 'typography/furio_text_styles.dart';

abstract final class FurioWidgetThemes {
  static SwitchThemeData switchTheme(FurioColorsExtension colors) =>
      SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? colors.surface
              : colors.onPrimary,
        ),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return colors.border;
          return states.contains(WidgetState.selected)
              ? colors.primary
              : colors.border;
        }),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
        trackOutlineWidth: const WidgetStatePropertyAll(0),

        thumbIcon: const WidgetStatePropertyAll(Icon(null)),
      );

  static ChipThemeData chip(FurioColorsExtension colors) => ChipThemeData(
    color: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return colors.border;
      return states.contains(WidgetState.selected)
          ? colors.primary.withValues(alpha: 0.10)
          : colors.surface;
    }),
    labelStyle: FurioTextStyles(colors).size14(color: colors.textSecondary),
    secondaryLabelStyle: FurioTextStyles(colors)
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

  static BottomSheetThemeData bottomSheet(FurioColorsExtension colors) =>
      BottomSheetThemeData(
        backgroundColor: colors.surfaceSheet,
        modalBackgroundColor: colors.surfaceSheet,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        clipBehavior: Clip.antiAlias,
      );

  static TextTheme textTheme(FurioColorsExtension colors) => TextTheme(
    displaySmall: FurioTextStyles(colors).size28(weight: FontWeight.w700),
    headlineMedium: FurioTextStyles(colors).size26(weight: FontWeight.w700),
    titleLarge: FurioTextStyles(colors).size21(weight: FontWeight.w600),
    titleMedium: FurioTextStyles(colors).size18(weight: FontWeight.w600),
    bodyLarge: FurioTextStyles(colors).size16(),
    bodyMedium: FurioTextStyles(colors).size14(),
    bodySmall: FurioTextStyles(colors).size12(color: colors.textSecondary),
    labelLarge: FurioTextStyles(colors).size15(weight: FontWeight.w600),
  );

  static FilledButtonThemeData filledButton(FurioColorsExtension colors) =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: FurioTextStyles(colors).size15(weight: FontWeight.w600),
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.disabled,
          disabledForegroundColor: colors.textSecondary,
        ),
      );

  static AppBarThemeData appBar(
    FurioColorsExtension colors, {
    required Brightness brightness,
  }) => AppBarThemeData(
    systemOverlayStyle: brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark,
    backgroundColor: colors.card,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: FurioTextStyles(colors).size21(),
    elevation: 0,
    scrolledUnderElevation: 0,
    toolbarHeight: 64,
    titleSpacing: 16,
  );

  static TabBarThemeData tabBar(FurioColorsExtension colors) => TabBarThemeData(
    tabAlignment: TabAlignment.center,
    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    labelColor: colors.primary,
    unselectedLabelColor: colors.textSecondary,
    labelStyle: FurioTextStyles(colors).size14(weight: FontWeight.w600),
    unselectedLabelStyle: FurioTextStyles(colors).size14(),
    indicatorColor: colors.primary,
    dividerColor: colors.border,
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed) ? Colors.transparent : null,
    ),
  );
}
