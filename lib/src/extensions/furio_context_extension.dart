import 'package:material_ui/material_ui.dart';

import '../theme/colors/furio_colors_extension.dart';
import '../theme/typography/furio_text_styles.dart';

extension FurioContextExtension on BuildContext {
  FurioTextStyles get typo => FurioTextStyles(color);
  FurioColorsExtension get color =>
      Theme.of(this).extension<FurioColorsExtension>() ??
      FurioColorsExtension.fromTheme(Theme.of(this));
}
