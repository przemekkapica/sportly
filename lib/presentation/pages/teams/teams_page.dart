import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/pages/teams/teams_page_cubit.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class TeamsPage extends HookWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<TeamsPageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [],
    );

    return Scaffold(
      body: state.maybeMap(
        idle: (state) {
          return Padding(
            padding: const EdgeInsets.all(AppDimens.sm),
            child: Column(
              children: [
                Text(
                  state.teams.length.toString(),
                  style: AppTypo.titleSmall,
                )
              ],
            ),
          );
        },
        orElse: () {
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
