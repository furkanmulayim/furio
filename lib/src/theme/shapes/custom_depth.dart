import 'package:material_ui/material_ui.dart';

abstract final class CustomDepth {
  static const floating = [
    BoxShadow(color: Color(0x18000000), blurRadius: 24, offset: Offset(0, 8)),
  ];

  static List<BoxShadow> get subdued => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.24),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}
