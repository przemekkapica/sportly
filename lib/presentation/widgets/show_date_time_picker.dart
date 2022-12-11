import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

void showDateTimePicker(
  BuildContext context,
  Function(DateTime)? onConfirm,
  DateTime initialDate,
) {
  DatePicker.showDateTimePicker(
    context,
    showTitleActions: true,
    onConfirm: onConfirm,
    currentTime: initialDate,
    theme: DatePickerTheme(
      itemStyle: AppTypo.bodySmall.copyWith(fontFamily: 'Montserrat'),
      cancelStyle: AppTypo.bodySmall.copyWith(
        fontFamily: 'Montserrat',
        color: AppColors.secondary,
      ),
      doneStyle: AppTypo.bodySmall.copyWith(
        fontFamily: 'Montserrat',
        decorationStyle: TextDecorationStyle.solid,
        color: Colors.blue,
        // fontWeight: FontWeight.bold,
      ),
    ),
  );
}
