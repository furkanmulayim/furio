import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';
import 'furio_button.dart';

class FurioSecondaryButton extends StatelessWidget {
  const FurioSecondaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.height = 44,
    super.key,
  }) : _fillsWidth = false;

  const factory FurioSecondaryButton.mini({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading,
    double height,
    Key? key,
  }) = FurioSecondaryButton;

  const FurioSecondaryButton.big({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.height = 44,
    super.key,
  }) : _fillsWidth = true;

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double height;
  final bool _fillsWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final baseStyle =
        FilledButtonTheme.of(context).style ?? const ButtonStyle();
    const disabled = {WidgetState.disabled};
    final secondaryStyle = FilledButton.styleFrom(
      backgroundColor: colors.border,
      foregroundColor: colors.hardOnPrimary,
      iconColor: colors.textPrimary,
      disabledBackgroundColor: baseStyle.backgroundColor?.resolve(disabled),
      disabledForegroundColor: baseStyle.foregroundColor?.resolve(disabled),
      disabledIconColor: baseStyle.iconColor?.resolve(disabled),
    );
    final button = _fillsWidth ? FurioButton.big : FurioButton.mini;

    return FilledButtonTheme(
      data: FilledButtonThemeData(
        style: baseStyle.copyWith(
          backgroundColor: secondaryStyle.backgroundColor,
          foregroundColor: secondaryStyle.foregroundColor,
          iconColor: secondaryStyle.iconColor,
          overlayColor: secondaryStyle.overlayColor,
        ),
      ),
      child: button(
        label: label,
        onPressed: onPressed,
        icon: icon,
        isLoading: isLoading,
        height: height,
      ),
    );
  }
}
