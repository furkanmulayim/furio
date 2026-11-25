import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';
import '../../theme/shapes/custom_corners.dart';
import '../list_tile/furio_list_tile.dart';
import '../sheet/furio_sheet.dart';

class FurioSelectField extends StatelessWidget {
  const FurioSelectField({
    required this.label,
    required this.options,
    required this.onChanged,
    this.value,
    this.leading,
    this.trailing,
    super.key,
  });

  final String label;
  final List<String> options;
  final String? value;
  final Widget? leading;
  final Widget? trailing;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => FurioListTile(
    title: label,
    subtitle: value ?? 'Seçiniz',
    leading: leading,
    trailing: trailing ?? const Icon(Icons.expand_more),
    onTap: options.isEmpty ? null : () => _showOptions(context),
  );

  Future<void> _showOptions(BuildContext context) async {
    final colors = context.color;
    final selectedBackground = Color.alphaBlend(
      colors.secondary.withValues(alpha: 0.14),
      colors.card,
    );
    String? pendingSelection;
    final selection = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => FurioSheet(
        title: label,
        content: StatefulBuilder(
          builder: (context, setState) {
            Future<void> select(String? option) async {
              if (option == null || pendingSelection != null) return;
              final route = ModalRoute.of(context);
              setState(() => pendingSelection = option);
              await Future<void>.delayed(const Duration(milliseconds: 300));
              if (!context.mounted || route == null || !route.isActive) return;
              if (route.isCurrent) {
                route.navigator?.pop(option);
              } else {
                setState(() => pendingSelection = null);
              }
            }

            final selected = pendingSelection ?? value;
            return RadioGroup<String>(
              groupValue: selected,
              onChanged: select,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: options
                    .map(
                      (option) => Material(
                        color: option == selected
                            ? selectedBackground
                            : colors.card,
                        borderRadius: CustomCorners.control,
                        clipBehavior: Clip.antiAlias,
                        child: FurioListTile(
                          title: option,
                          trailing: Radio<String>(value: option),
                          onTap: () => select(option),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );

    if (context.mounted && selection != null) onChanged(selection);
  }
}
