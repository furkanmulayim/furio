import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../extensions/custom_context_extension.dart';

class FurioTextField extends StatelessWidget {
  const FurioTextField({
    required this.label,
    this.headingBraceledText,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.hintText,
    this.helperText,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.suffixText,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.multiLine = false,
    this.lines = 3,
    this.maxLength,
    this.isError = false,
    this.errorText,
    this.textStyle,
    this.hintStyle,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.validator,
    this.autovalidateMode,
    this.autofillHints,
    super.key,
  }) : assert(controller == null || initialValue == null),
       assert(lines > 0),
       assert(!obscureText || !multiLine),
       assert(prefixIcon == null || prefixWidget == null);

  final String label;
  final String? headingBraceledText;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? hintText;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final String? suffixText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool multiLine;
  final int lines;
  final int? maxLength;
  final bool isError;
  final String? errorText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final scheme = Theme.of(context).colorScheme;
    final hasError = isError || errorText != null;
    final foreground = enabled ? colors.textPrimary : colors.textSecondary;
    final leading =
        prefixWidget ?? (prefixIcon == null ? null : Icon(prefixIcon));
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );
    final iconColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return colors.disabled;
      if (hasError || states.contains(WidgetState.error)) return scheme.error;
      return states.contains(WidgetState.focused)
          ? colors.primary
          : colors.textSecondary;
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text.rich(
              TextSpan(
                text: label,
                children: [
                  if (headingBraceledText != null)
                    TextSpan(text: ' ($headingBraceledText)'),
                ],
              ),
              style: context.typo.size12(color: colors.textSecondary),
            ),
          ),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode,
          autofocus: autofocus,
          readOnly: readOnly,
          enabled: enabled,
          keyboardType:
              keyboardType ?? (multiLine ? TextInputType.multiline : null),
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          minLines: multiLine ? lines : 1,
          maxLines: multiLine ? lines : 1,
          maxLength: maxLength,
          textAlignVertical: multiLine
              ? TextAlignVertical.top
              : TextAlignVertical.center,
          style:
              textStyle ??
              context.typo.size14(color: foreground, weight: FontWeight.w400),
          cursorColor: hasError ? scheme.error : colors.primary,
          cursorErrorColor: scheme.error,
          cursorWidth: 1,
          cursorHeight: 20,
          scrollPadding: const EdgeInsets.only(bottom: 76),
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          validator: validator,
          autovalidateMode: autovalidateMode,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            constraints: const BoxConstraints(minHeight: 52),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            filled: true,
            fillColor: enabled ? colors.card : colors.surface,
            hintText: hintText,
            hintStyle:
                hintStyle ??
                context.typo.size14(
                  color: colors.textSecondary,
                  weight: FontWeight.w400,
                ),
            helperText: helperText,
            helperStyle: context.typo.size12(color: colors.textSecondary),
            suffixText: suffixText,
            suffixStyle: context.typo.size14(
              color: foreground,
              weight: FontWeight.w600,
            ),
            border: border(colors.border),
            enabledBorder: border(hasError ? scheme.error : colors.border),
            focusedBorder: border(
              hasError
                  ? scheme.error
                  : colors.textSecondary.withValues(alpha: 0.22),
              1.5,
            ),
            disabledBorder: border(colors.border),
            errorBorder: border(scheme.error),
            focusedErrorBorder: border(scheme.error, 1.5),
            errorText: errorText,
            errorMaxLines: 3,
            errorStyle: context.typo.size12(color: scheme.error),
            prefixIconColor: iconColor,
            suffixIconColor: iconColor,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 42,
              minHeight: 48,
            ),
            prefixIcon: leading == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: IconTheme.merge(
                      data: const IconThemeData(size: 19),
                      child: leading,
                    ),
                  ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
