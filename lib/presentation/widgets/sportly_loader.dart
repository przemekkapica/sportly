import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';

class SportlyLoader extends StatelessWidget {
  const SportlyLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
