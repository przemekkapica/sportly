import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection.dart';

class ScheduleEntryPage extends StatelessWidget {
  const ScheduleEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: TeamSelection(
        entryPage: EntryPage.schedule,
      ),
    );
  }
}
