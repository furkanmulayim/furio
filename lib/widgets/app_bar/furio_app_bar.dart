import 'dart:ui' show ImageFilter;

import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';

/// A blurred app bar that sizes itself to its visible content and [bottom].
///
/// Wrap it in a [PinnedHeaderSliver] to keep it above scrolling content.
class FurioAppBar extends StatelessWidget {
  const FurioAppBar({
    this.title,
    this.subtitle,
    this.leading,
    this.firstAction,
    this.secondAction,
    this.bottom,
    super.key,
  });

  final String? title;
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
    final title = this.title;
    final hasTitle = title != null && title.trim().isNotEmpty;
    final labels = [
      if (hasTitle)
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: typography.size18(),
        ),
      if (subtitle case final text? when text.trim().isNotEmpty)
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: typography.size12(color: colors.textSecondary),
        ),
    ];
    final hasToolbar =
        labels.isNotEmpty || leading != null || actions.isNotEmpty;

    final toolbar = ConstrainedBox(
      constraints: BoxConstraints(minHeight: hasTitle ? kToolbarHeight : 0),
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
              if (labels.isNotEmpty) const SizedBox(width: 10),
            ],
            if (labels.isNotEmpty)
              Expanded(
                child: Semantics(
                  header: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: labels,
                  ),
                ),
              )
            else
              const Spacer(),
            if (labels.isNotEmpty && actions.isNotEmpty)
              const SizedBox(width: 16),
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
                  children: [if (hasToolbar) toolbar, ?bottom],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
