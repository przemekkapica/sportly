import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sport_discipline_icon.dart';

class SelectedTeamIndicator extends StatelessWidget {
  const SelectedTeamIndicator({
    super.key,
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset.fromDirection(-3, 10),
      elevation: 4.0,
      position: PopupMenuPosition.under,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimens.borderRadius),
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: Text(
            team.name,
            style: AppTypo.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            context.router.navigate(
              TeamsRouter(
                children: [
                  const TeamsPageRoute(),
                  TeamDetailsPageRoute(teamId: team.id)
                ],
              ),
            );
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SportDisciplineIcon(
          discipline: team.discipline,
          size: AppDimens.teamIndicatorSize,
        ),
      ),
    );
  }
}
