import 'package:material_ui/material_ui.dart';

import '../../theme/shapes/custom_corners.dart';

class FurioSnackBar extends SnackBar {
  FurioSnackBar({
    required String title,
    required IconData icon,
    String? actionLabel,
    VoidCallback? onPressed,
    super.key,
  }) : super(
         behavior: SnackBarBehavior.floating,
         shape: const RoundedRectangleBorder(
           borderRadius: CustomCorners.control,
         ),
         action: onPressed != null && actionLabel != null
             ? SnackBarAction(label: actionLabel, onPressed: onPressed)
             : null,
         content: Builder(
           builder: (context) {
             final color = DefaultTextStyle.of(context).style.color;
             return Row(
               children: [
                 Icon(icon, size: 20, color: color),
                 const SizedBox(width: 10),
                 Expanded(child: Text(title)),
                 if (onPressed != null && actionLabel == null)
                   IconButton(
                     tooltip: 'Aç',
                     color: color,
                     icon: const Icon(Icons.arrow_forward),
                     onPressed: () {
                       ScaffoldMessenger.of(context).hideCurrentSnackBar(
                         reason: SnackBarClosedReason.action,
                       );
                       onPressed();
                     },
                   ),
               ],
             );
           },
         ),
       );
}
