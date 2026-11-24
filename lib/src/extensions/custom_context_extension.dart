import 'package:material_ui/material_ui.dart';

import '../theme/colors/custom_colors_extension.dart';
import '../theme/typography/custom_text_styles.dart';

extension CustomContextExtension on BuildContext {
  CustomTextStyles get typo => CustomTextStyles(color);
  CustomColorsExtension get color =>
      Theme.of(this).extension<CustomColorsExtension>() ??
      CustomColorsExtension.fromTheme(Theme.of(this));
}
