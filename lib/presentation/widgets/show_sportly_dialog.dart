import 'package:flutter/material.dart';

Future<void> showSportlyDialog(
  BuildContext context,
  Widget title,
  Widget content,
  List<Widget> actions,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    },
  );
}
