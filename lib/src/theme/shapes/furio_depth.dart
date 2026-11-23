import 'package:material_ui/material_ui.dart';

import '../colors/furio_palette.dart';

abstract final class FurioDepth {
  static const floating = [
    BoxShadow(color: Color(0x185146B5), blurRadius: 24, offset: Offset(0, 8)),
  ];

  static List<BoxShadow> get subdued => [
    BoxShadow(
      color: FurioPalette.midnight.withValues(alpha: 0.24),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}
