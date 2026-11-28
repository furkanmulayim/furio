import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';
import '../../theme/shapes/custom_corners.dart';

class FurioInfo extends StatelessWidget {
  const FurioInfo({required this.icon, required this.text, super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final foreground = colors.textPrimary.withValues(alpha: 0.72);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.08),
        borderRadius: CustomCorners.control,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: foreground),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: context.typo
                  .size14(color: foreground)
                  .copyWith(height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}
