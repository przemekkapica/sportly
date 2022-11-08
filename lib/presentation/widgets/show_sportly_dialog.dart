import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

Future<void> showSportlyDialog(
  BuildContext context,
  Widget title,
  Widget content,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.borderRadius),
          ),
        ),
        content: content,
        insetPadding: const EdgeInsets.all(AppDimens.md),
      );
    },
  );
}
