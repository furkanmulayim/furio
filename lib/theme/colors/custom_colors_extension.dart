import 'package:material_ui/material_ui.dart';

import 'custom_colors.dart';

@immutable
class CustomColorsExtension extends ThemeExtension<CustomColorsExtension> {
  const CustomColorsExtension({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.surfaceSheet,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.disabled,
  });
  final Color primary;
  final Color onPrimary;
  final Color surface;
  final Color surfaceSheet;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color disabled;

  static const light = CustomColorsExtension(
    primary: CustomColors.primaryLight,
    onPrimary: CustomColors.onPrimaryLight,
    surface: CustomColors.surfaceLight,
    surfaceSheet: CustomColors.surfaceSheetLight,
    card: CustomColors.cardLight,
    textPrimary: CustomColors.textPrimaryLight,
    textSecondary: CustomColors.textSecondaryLight,
    border: CustomColors.borderLight,
    disabled: CustomColors.disabledLight,
  );

  static const dark = CustomColorsExtension(
    primary: CustomColors.primaryDark,
    onPrimary: CustomColors.onPrimaryDark,
    surface: CustomColors.surfaceDark,
    surfaceSheet: CustomColors.surfaceSheetDark,
    card: CustomColors.cardDark,
    textPrimary: CustomColors.textPrimaryDark,
    textSecondary: CustomColors.textSecondaryDark,
    border: CustomColors.borderDark,
    disabled: CustomColors.disabledDark,
  );

  factory CustomColorsExtension.fromTheme(ThemeData theme) {
    final scheme = theme.colorScheme;
    return CustomColorsExtension(
      primary: scheme.primary,
      onPrimary: scheme.onPrimary,
      surface: scheme.surface,
      surfaceSheet:
          theme.bottomSheetTheme.backgroundColor ?? scheme.surfaceContainerLow,
      card: theme.cardTheme.color ?? scheme.surfaceContainerLow,
      textPrimary: scheme.onSurface,
      textSecondary: scheme.onSurfaceVariant,
      border: scheme.outlineVariant,
      disabled: scheme.onSurface.withValues(alpha: 0.38),
    );
  }

  @override
  CustomColorsExtension copyWith({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? surfaceSheet,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? disabled,
  }) => CustomColorsExtension(
    primary: primary ?? this.primary,
    onPrimary: onPrimary ?? this.onPrimary,
    surface: surface ?? this.surface,
    surfaceSheet: surfaceSheet ?? this.surfaceSheet,
    card: card ?? this.card,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    border: border ?? this.border,
    disabled: disabled ?? this.disabled,
  );

  @override
  CustomColorsExtension lerp(covariant CustomColorsExtension? other, double t) {
    if (other == null) return this;
    return CustomColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSheet: Color.lerp(surfaceSheet, other.surfaceSheet, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
    );
  }
}
