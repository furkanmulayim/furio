import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';

class TabItem {
  const TabItem({required this.title, this.icon});
  final String title;
  final IconData? icon;
}

class FurioSegmentedButton extends StatefulWidget {
  const FurioSegmentedButton({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.verticalPadding = 0,
    this.horizontalPadding = 0,
    this.selectedColor,
    this.selectedTextColor,
    this.contentHeight = 30,
    this.fontSize,
    this.onChanged,
  });

  final List<TabItem> items;
  final int initialIndex;
  final double verticalPadding;
  final double horizontalPadding;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final double contentHeight;
  final double? fontSize;
  final ValueChanged<int>? onChanged;

  @override
  State<FurioSegmentedButton> createState() => _FurioSegmentedButtonState();
}

class _FurioSegmentedButtonState extends State<FurioSegmentedButton> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, widget.items.length - 1);
  }

  @override
  void didUpdateWidget(covariant FurioSegmentedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex ||
        widget.items.length != oldWidget.items.length) {
      _index = widget.initialIndex.clamp(0, widget.items.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    if (items.isEmpty) return const SizedBox.shrink();
    final index = _index.clamp(0, items.length - 1);
    final colors = context.color;
    final styles = context.typo;
    final selectedColor = widget.selectedColor ?? colors.primary;
    final selectedTextColor = widget.selectedTextColor ?? colors.onPrimary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            ((constraints.maxWidth) - (widget.horizontalPadding * 2 + 10)) /
            items.length;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: colors.card,
              border: Border.all(
                color: colors.border,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: SizedBox(
              height: widget.contentHeight,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                    left: width * index,
                    width: width,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(items.length, (i) {
                      final selected = i == index;
                      final item = items[i];

                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() => _index = i);
                            widget.onChanged?.call(i);
                          },
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  item.title,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: styles
                                      .size14(
                                        color: selected
                                            ? selectedTextColor
                                            : colors.textPrimary,
                                        weight: selected
                                            ? FontWeight.w600
                                            : null,
                                      )
                                      .copyWith(fontSize: widget.fontSize),
                                ),
                              ),  
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
