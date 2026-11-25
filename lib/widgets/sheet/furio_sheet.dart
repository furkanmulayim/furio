import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';
import '../button/furio_button.dart';

class FurioSheet extends StatelessWidget {
  const FurioSheet({
    required this.content,
    this.title,
    this.onClose,
    this.isFullScreen = false,
    this.buttonText,
    this.onButtonPressed,
    this.isButtonDisabled = false,
    this.contentPadding = const EdgeInsets.fromLTRB(20, 0, 20, 20),
    super.key,
  });

  final Widget content;
  final String? title;
  final VoidCallback? onClose;
  final bool isFullScreen;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool isButtonDisabled;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.sizeOf(context).height;
        final height = math.min(constraints.maxHeight, screenHeight);
        final keyboard = MediaQuery.viewInsetsOf(context).bottom;
        final available = math.max(0.0, height - keyboard);
        final limit = isFullScreen
            ? available
            : math.min(available, screenHeight * 0.9);
        return Padding(
          padding: EdgeInsets.only(bottom: math.min(keyboard, height)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: isFullScreen ? limit : 0,
              maxHeight: limit,
            ),
            child: Material(
              color: context.color.surfaceSheet,
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: isFullScreen
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 24),
                      child: Center(
                        child: ExcludeSemantics(
                          child: Container(
                            width: 36,
                            height: 4,
                            decoration: BoxDecoration(
                              color: context.color.disabled,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (title != null || onClose != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 12, 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: title == null
                                  ? const SizedBox.shrink()
                                  : Text(title!, style: context.typo.size24()),
                            ),
                            if (onClose != null)
                              CloseButton(onPressed: onClose),
                          ],
                        ),
                      ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: contentPadding,
                            child: content,
                          ),
                        ),
                      ),
                    ),
                    if (onButtonPressed != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: FurioButton.big(
                          label: buttonText ?? 'Uygula',
                          onPressed: isButtonDisabled ? null : onButtonPressed,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
