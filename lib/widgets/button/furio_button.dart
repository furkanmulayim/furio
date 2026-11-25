import 'package:material_ui/material_ui.dart';

class FurioButton extends StatelessWidget {
  static const double _minimumHeight = 44;

  const FurioButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.height = _minimumHeight,
    super.key,
  }) : _fillsWidth = false;

  const FurioButton._big({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.height = _minimumHeight,
    super.key,
  }) : _fillsWidth = true;

  const factory FurioButton.mini({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading,
    double height,
    Key? key,
  }) = FurioButton;

  /// Fills the available width when the parent provides a finite width.
  ///
  /// Use Expanded around the button to fill the remaining space in a Row.
  const factory FurioButton.big({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading,
    double height,
    Key? key,
  }) = FurioButton._big;

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double height;
  final bool _fillsWidth;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final button = FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) ...[
            SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.onSurface.withValues(alpha: 0.38),
                semanticsLabel: 'Yükleniyor',
              ),
            ),
            const SizedBox(width: 8),
          ] else if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
    final buttonHeight = height < _minimumHeight ? _minimumHeight : height;

    if (!_fillsWidth) {
      return Align(
        widthFactor: 1,
        heightFactor: 1,
        child: SizedBox(height: buttonHeight, child: button),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.hasBoundedWidth ? constraints.maxWidth : null,
        height: buttonHeight,
        child: button,
      ),
    );
  }
}
