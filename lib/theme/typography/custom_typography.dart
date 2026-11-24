import 'package:material_ui/material_ui.dart';

abstract final class CustomTypography {
  static const fontFamily = 'Urbanist';
  static const fontPackage = 'furio';
  static const packageFontFamily = 'packages/furio/Urbanist';
  static const hero = TextStyle(
    fontFamily: fontFamily,
    package: fontPackage,
    fontSize: 36,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
  );
  static const heading = TextStyle(
    fontFamily: fontFamily,
    package: fontPackage,
    fontSize: 26,
    height: 1.3,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );
  static const section = TextStyle(
    fontFamily: fontFamily,
    package: fontPackage,
    fontSize: 19,
    height: 1.4,
    fontWeight: FontWeight.w600,
  );
  static const paragraph = TextStyle(
    fontFamily: fontFamily,
    package: fontPackage,
    fontSize: 16,
    height: 1.5,
  );
  static const supporting = TextStyle(
    fontFamily: fontFamily,
    package: fontPackage,
    fontSize: 14,
    height: 1.5,
  );
  static const action = TextStyle(
    fontFamily: fontFamily,
    package: fontPackage,
    fontSize: 15,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );
  static const caption = TextStyle(
    fontFamily: fontFamily,
    package: fontPackage,
    fontSize: 12,
    height: 1.4,
  );

  static TextTheme resolve(Color foreground, Color muted) => TextTheme(
    displaySmall: hero.copyWith(color: foreground),
    headlineMedium: heading.copyWith(color: foreground),
    titleLarge: section.copyWith(color: foreground),
    titleMedium: section.copyWith(fontSize: 17, color: foreground),
    bodyLarge: paragraph.copyWith(color: foreground),
    bodyMedium: supporting.copyWith(color: foreground),
    bodySmall: caption.copyWith(color: muted),
    labelLarge: action.copyWith(color: foreground),
    labelSmall: caption.copyWith(color: muted),
  );
}
