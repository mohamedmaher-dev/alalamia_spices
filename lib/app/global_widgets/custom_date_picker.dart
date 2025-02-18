import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import '../data/providers/translations.dart';

class CustomDatePicker {
  static void showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required Function(DateTime) onConfirm,
    DateTimePickerLocale locale = DateTimePickerLocale.en_us,
    String format = 'yyyy-MM-dd',
  }) {
    DatePicker.showDatePicker(
      context,
      pickerTheme:  DateTimePickerTheme(
        backgroundColor: Theme.of(context).colorScheme.background,
        itemTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontFamily: "cairo",
            fontWeight: FontWeight.bold
        ),
        showTitle: true,
        confirm:  Text(
            allTranslations.text('agree'),
            style: Theme.of(context).textTheme.bodyMedium
        ),
        cancel: Text(
            allTranslations.text('cancel'),
            style: Theme.of(context).textTheme.bodyMedium
        ),
      ),
      minDateTime: DateTime(initialDate.year),
      maxDateTime: DateTime(initialDate.year , 13),
      initialDateTime: initialDate,
      dateFormat: format,
      locale: locale,
      onClose: () => print("DatePicker closed"),
      onCancel: () => print('Cancelled'),
      onConfirm: (dateTime, List<int> index) {
        onConfirm(dateTime);
      },
    );
  }
}