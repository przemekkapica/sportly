import 'package:flutter/material.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

class SportDisciplineIcon extends StatelessWidget {
  const SportDisciplineIcon({
    Key? key,
    required this.discipline,
    required this.size,
  }) : super(key: key);

  final SportDiscipline discipline;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size + AppDimens.xsm,
      // width: size + ,
      decoration: BoxDecoration(
        color: getColor(discipline),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.sm),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.xsm),
        child: Center(
          child: Icon(
            getIcon(discipline),
            size: size,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

IconData getIcon(SportDiscipline discipline) {
  if (discipline.name == 'Football') {
    return Icons.sports_soccer_rounded;
  } else if (discipline.name == 'Basketball') {
    return Icons.sports_basketball_rounded;
  } else if (discipline.name == 'Handball') {
    return Icons.sports_handball_rounded;
  } else if (discipline.name == 'Volleyball') {
    return Icons.sports_volleyball_rounded;
  } else if (discipline.name == 'Tennis') {
    return Icons.sports_tennis_rounded;
  } else if (discipline.name == 'Jogging') {
    return Icons.directions_run_outlined;
  } else {
    return Icons.sports_bar_rounded;
  }
}

Color getColor(SportDiscipline discipline) {
  if (discipline.name == 'Football') {
    return AppColors.team1.withAlpha(160);
  } else if (discipline.name == 'Basketball') {
    return AppColors.team2.withAlpha(160);
  } else if (discipline.name == 'Handball') {
    return AppColors.team3.withAlpha(160);
  } else if (discipline.name == 'Jogging') {
    return AppColors.team5.withAlpha(160);
  } else if (discipline.name == 'Tennis') {
    return AppColors.team4.withAlpha(160);
  } else if (discipline.name == 'Volleyball') {
    return AppColors.team4.withAlpha(160);
  } else {
    return AppColors.team1.withAlpha(160);
  }
}
