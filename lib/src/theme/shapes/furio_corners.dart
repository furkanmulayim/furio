import 'package:material_ui/material_ui.dart';

abstract final class FurioCorners {
  static const control = BorderRadius.all(Radius.circular(14));
  static const panel = BorderRadius.all(Radius.circular(22));
  static const sheet = BorderRadius.vertical(top: Radius.circular(30));
  static const badge = BorderRadius.all(Radius.circular(100));
}
