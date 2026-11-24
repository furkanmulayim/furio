import 'package:material_ui/material_ui.dart';

import 'colors/custom_colors.dart';
import 'colors/custom_colors_extension.dart';
import 'custom_widget_themes.dart';
import 'shapes/custom_corners.dart';
import 'typography/custom_typography.dart';

abstract final class CustomTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final night = brightness == Brightness.dark;
    final semantic = night
        ? CustomColorsExtension.dark
        : CustomColorsExtension.light;
    final ink = semantic.textPrimary;
    final muted = semantic.textSecondary;
    final canvas = semantic.surface;
    final panel = semantic.card;
    final line = semantic.border;
    final accent = semantic.primary;
    final colors = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
      primary: accent,
      onPrimary: semantic.onPrimary,
      secondary: night
          ? CustomColors.secondaryDark
          : CustomColors.secondaryLight,
      onSecondary: semantic.onPrimary,
      surface: canvas,
      onSurface: ink,
      onSurfaceVariant: muted,
      surfaceContainerLowest: panel,
      surfaceContainerLow: panel,
      surfaceContainerHighest: night
          ? CustomColors.surfaceContainerHighestDark
          : CustomColors.surfaceContainerHighestLight,
      outline: line,
      outlineVariant: line,
      error: Colors.red,
      onError: semantic.onPrimary,
      scrim: Colors.black,
    );
    final type = CustomWidgetThemes.textTheme(semantic);
    final control = RoundedRectangleBorder(borderRadius: CustomCorners.control);
    OutlineInputBorder inputBorder(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: CustomCorners.control,
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      fontFamily: CustomTypography.packageFontFamily,
      extensions: [semantic],
      brightness: brightness,
      colorScheme: colors,
      scaffoldBackgroundColor: canvas,
      disabledColor: semantic.disabled,
      textTheme: type,
      appBarTheme: CustomWidgetThemes.appBar(semantic, brightness: brightness),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: panel,
        shape: RoundedRectangleBorder(
          borderRadius: CustomCorners.panel,
          side: BorderSide(color: line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: panel,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        labelStyle: type.bodyMedium?.copyWith(color: muted),
        border: inputBorder(line),
        enabledBorder: inputBorder(line),
        disabledBorder: inputBorder(line.withValues(alpha: 0.5)),
        focusedBorder: inputBorder(accent, 2),
        errorBorder: inputBorder(colors.error),
        focusedErrorBorder: inputBorder(colors.error, 2),
      ),
      filledButtonTheme: CustomWidgetThemes.filledButton(semantic),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 50),
          shape: control,
          side: BorderSide(color: line),
          textStyle: type.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: control, textStyle: type.labelLarge),
      ),
      dividerTheme: DividerThemeData(color: line, thickness: 1, space: 24),
      bottomSheetTheme: CustomWidgetThemes.bottomSheet(semantic),
      dialogTheme: DialogThemeData(
        backgroundColor: panel,
        shape: const RoundedRectangleBorder(borderRadius: CustomCorners.panel),
        titleTextStyle: type.titleLarge,
        contentTextStyle: type.bodyLarge,
      ),
      chipTheme: CustomWidgetThemes.chip(semantic),
      switchTheme: CustomWidgetThemes.switchTheme(semantic),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      // Flutter, hizalamayı sekme çubuğunun kaydırma ayarına göre seçer.
      tabBarTheme: CustomWidgetThemes.tabBar(semantic, tabAlignment: null),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: panel,
        indicatorColor: accent.withValues(alpha: 0.16),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ink,
        contentTextStyle: type.bodyMedium?.copyWith(color: canvas),
        actionTextColor: semantic.onPrimary,
        shape: control,
      ),
    );
  }
}
