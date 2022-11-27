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
      decoration: BoxDecoration(
        color: getColor(discipline),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.sm),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.xsm),
        child: getIcon(discipline, size),
      ),
    );
  }
}

Icon getIcon(SportDiscipline discipline, double size) {
  if (discipline.name == 'Football') {
    return Icon(
      Icons.sports_soccer_rounded,
      size: size,
    );
  } else if (discipline.name == 'Basketball') {
    return Icon(
      Icons.sports_basketball_rounded,
      size: size,
    );
  } else if (discipline.name == 'Handball') {
    return Icon(
      Icons.sports_handball_rounded,
      size: size,
    );
  } else if (discipline.name == 'Tennis') {
    return Icon(
      Icons.sports_tennis_rounded,
      size: size,
    );
  } else if (discipline.name == 'Jogging') {
    return Icon(
      Icons.directions_run_outlined,
      size: size,
    );
  } else {
    return Icon(
      Icons.sports_bar_rounded,
      size: size,
    );
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
    return AppColors.team4.withAlpha(160);
  } else if (discipline.name == 'Tennis') {
    return AppColors.team4.withAlpha(160);
  } else {
    return AppColors.team1.withAlpha(160);
  }
}
