import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    this.title,
    this.subtitle,
    this.padding = const EdgeInsets.all(20),
    super.key,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final styles = context.typo;
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(title!, style: styles.size18(weight: FontWeight.w600)),
            if (title != null && subtitle != null) const SizedBox(height: 4),
            if (subtitle != null)
              Text(
                subtitle!,
                style: styles.size14(color: context.color.textSecondary),
              ),
            if (title != null || subtitle != null) const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
