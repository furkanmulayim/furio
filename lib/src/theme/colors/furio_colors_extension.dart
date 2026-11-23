import 'package:material_ui/material_ui.dart';

import 'furio_colors.dart';

@immutable
class FurioColorsExtension extends ThemeExtension<FurioColorsExtension> {
  const FurioColorsExtension({
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

  static const light = FurioColorsExtension(
    primary: FurioColors.primaryLight,
    onPrimary: FurioColors.onPrimaryLight,
    surface: FurioColors.surfaceLight,
    surfaceSheet: FurioColors.surfaceSheetLight,
    card: FurioColors.cardLight,
    textPrimary: FurioColors.textPrimaryLight,
    textSecondary: FurioColors.textSecondaryLight,
    border: FurioColors.borderLight,
    disabled: FurioColors.disabledLight,
  );

  static const dark = FurioColorsExtension(
    primary: FurioColors.primaryDark,
    onPrimary: FurioColors.onPrimaryDark,
    surface: FurioColors.surfaceDark,
    surfaceSheet: FurioColors.surfaceSheetDark,
    card: FurioColors.cardDark,
    textPrimary: FurioColors.textPrimaryDark,
    textSecondary: FurioColors.textSecondaryDark,
    border: FurioColors.borderDark,
    disabled: FurioColors.disabledDark,
  );

  factory FurioColorsExtension.fromTheme(ThemeData theme) {
    final scheme = theme.colorScheme;
    return FurioColorsExtension(
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
  FurioColorsExtension copyWith({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? surfaceSheet,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? disabled,
  }) => FurioColorsExtension(
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
  FurioColorsExtension lerp(covariant FurioColorsExtension? other, double t) {
    if (other == null) return this;
    return FurioColorsExtension(
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
