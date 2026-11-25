import 'package:material_ui/material_ui.dart';

import '../sheet/furio_sheet.dart';

enum FurioDatePickerMode {
  /// From January 1, 2020 through today.
  past,

  /// From today through December 31, 2035.
  future,

  /// From January 1, 2020 through December 31, 2035.
  any,
}

abstract final class FurioDatePicker {
  /// Opens a bottom sheet and returns the confirmed date in local time at
  /// midnight. Returns null when dismissed or when the range is empty.
  ///
  /// The range includes both endpoints. [initialDate] defaults to today and
  /// moves to the nearest endpoint if it falls outside the range.
  static Future<DateTime?> show(
    BuildContext context, {
    required FurioDatePickerMode mode,
    DateTime? initialDate,
  }) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final firstDate = mode == FurioDatePickerMode.future
        ? today
        : DateTime(2020);
    final lastDate = mode == FurioDatePickerMode.past
        ? today
        : DateTime(2035, 12, 31);
    if (firstDate.isAfter(lastDate)) return null;

    var selectedDate = DateUtils.dateOnly(initialDate ?? today);
    if (selectedDate.isBefore(firstDate)) {
      selectedDate = firstDate;
    } else if (selectedDate.isAfter(lastDate)) {
      selectedDate = lastDate;
    }

    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: false,
      builder: (sheetContext) {
        final localizations = MaterialLocalizations.of(sheetContext);
        final navigator = Navigator.of(sheetContext);
        final pickerTheme = DatePickerTheme.of(sheetContext);
        final defaults = DatePickerTheme.defaults(sheetContext);
        final toggleStyle =
            pickerTheme.toggleButtonTextStyle ?? defaults.toggleButtonTextStyle;
        return FurioSheet(
          title: localizations.datePickerHelpText,
          onClose: () => navigator.pop(),
          buttonText: localizations.okButtonLabel,
          onButtonPressed: () => navigator.pop(selectedDate),
          content: DatePickerTheme(
            data: pickerTheme.copyWith(
              weekdayStyle: (pickerTheme.weekdayStyle ?? defaults.weekdayStyle)
                  ?.copyWith(fontWeight: FontWeight.bold),
              toggleButtonTextStyle: toggleStyle?.apply(
                color:
                    pickerTheme.toggleButtonTextStyle?.color ??
                    pickerTheme.subHeaderForegroundColor,
                fontSizeDelta: 2,
              ),
            ),
            child: IconTheme.merge(
              data: const IconThemeData(size: 28),
              child: CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: firstDate,
                lastDate: lastDate,
                currentDate: today,
                onDateChanged: (date) => selectedDate = date,
              ),
            ),
          ),
        );
      },
    );
  }
}
