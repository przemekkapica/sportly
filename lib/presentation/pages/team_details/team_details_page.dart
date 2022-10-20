import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_cubit.dart';
import 'package:sportly/presentation/pages/teams/teams_page_cubit.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/primary_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';

class TeamDetailsPage extends HookWidget {
  const TeamDetailsPage({
    Key? key,
    @PathParam() required this.teamId,
  }) : super(key: key);

  final String teamId;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<TeamDetailsPageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init(teamId);
      },
      [],
    );

    return Container();
  }
}
