import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.sm),
        child: Column(
          children: const [
            Text(
              'SCHEDULE',
              style: AppTypo.titleSmall,
            )
          ],
        ),
      ),
    );
  }
}
