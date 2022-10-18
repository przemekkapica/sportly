import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/pages/teams/teams_page_cubit.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/primary_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';

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
      backgroundColor: AppColors.background,
      body: state.maybeMap(
        idle: (state) {
          return Padding(
            padding: const EdgeInsets.all(AppDimens.sm),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return SportlyCard(
                        content: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.team1.withAlpha(160),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(AppDimens.sm),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(AppDimens.xsm),
                                child: Icon(
                                  Icons.sports_soccer_rounded,
                                  size: 50,
                                ),
                              ),
                            ),
                            const Gap(AppDimens.md),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.teams[index].name,
                                  style: AppTypo.bodyMedium,
                                ),
                                const Gap(AppDimens.xxsm),
                                Text(
                                  state.teams[index].membersCount.toString() +
                                      ' members',
                                  style: AppTypo.labelLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.teams.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(AppDimens.sm);
                    },
                  ),
                ),
                Column(
                  children: [
                    const Gap(AppDimens.sm),
                    PrimaryButton.solid(
                      label: 'Join a team',
                      onTap: () {},
                    ),
                    const Gap(AppDimens.xsm),
                    PrimaryButton.outlined(
                      label: 'Create a team',
                      onTap: () {},
                    ),
                  ],
                ),
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
