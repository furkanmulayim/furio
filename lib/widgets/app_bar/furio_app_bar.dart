import 'dart:ui' show ImageFilter;

import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';

/// A blurred app bar that sizes itself to its toolbar and optional [bottom].
///
/// Wrap it in a [PinnedHeaderSliver] to keep it above scrolling content.
class FurioAppBar extends StatelessWidget {
  const FurioAppBar({
    required this.title,
    this.subtitle,
    this.leading,
    this.firstAction,
    this.secondAction,
    this.bottom,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? firstAction;
  final Widget? secondAction;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final typography = context.typo;
    final theme = Theme.of(context);
    final actions = [?firstAction, ?secondAction];

    final toolbar = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: kToolbarHeight),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          16,
          4,
          actions.isEmpty ? 16 : 8,
          4,
        ),
        child: Row(
          children: [
            if (leading case final leadingWidget?) ...[
              SizedBox.square(dimension: 40, child: leadingWidget),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Semantics(
                header: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: typography.size18(),
                    ),
                    if (subtitle case final subtitleText?)
                      Text(
                        subtitleText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: typography.size12(color: colors.textSecondary),
                      ),
                  ],
                ),
              ),
            ),
            if (actions.isNotEmpty) const SizedBox(width: 16),
            for (final action in actions)
              IconTheme.merge(
                data: IconThemeData(size: 26, color: colors.textPrimary),
                child: action,
              ),
          ],
        ),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          theme.appBarTheme.systemOverlayStyle ??
          (theme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: colors.card.withValues(alpha: 0.72),
            foregroundDecoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.border)),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [toolbar, ?bottom],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
