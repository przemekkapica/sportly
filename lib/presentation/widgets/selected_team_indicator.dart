import 'package:flutter/material.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/presentation/widgets/sport_discipline_icon.dart';

class SelectedTeamIndicator extends StatelessWidget {
  const SelectedTeamIndicator({
    super.key,
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SportDisciplineIcon(
        discipline: team.discipline,
        size: 24,
      ),
    );
  }
}
