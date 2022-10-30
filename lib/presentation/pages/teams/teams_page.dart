import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/teams/teams_page_cubit.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sport_discipline_icon.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
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
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return SportlyCard(
                        onTap: () {
                          AutoRouter.of(context).push(
                            TeamDetailsPageRoute(teamId: state.teams[index].id),
                          );
                        },
                        content: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SportDisciplineIcon(
                              discipline: state.teams[index].discipline,
                              size: AppDimens.disciplineIconSize,
                            ),
                            const Gap(AppDimens.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.teams[index].name,
                                    style: AppTypo.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const Gap(AppDimens.xxsm),
                                  Text(
                                    state.teams[index].membersCount.toString() +
                                        LocaleKeys.teams_page_members.tr(),
                                    style: AppTypo.labelLarge,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(AppDimens.borderRadius),
                                ),
                              ),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                const PopupMenuItem(
                                  child: Text(
                                    'Manage',
                                    style: AppTypo.bodySmall,
                                  ),
                                ),
                                const PopupMenuItem(
                                  child: Text(
                                    'Invite people',
                                    style: AppTypo.bodySmall,
                                  ),
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Leave team',
                                    style: AppTypo.bodySmall
                                        .copyWith(color: AppColors.danger),
                                  ),
                                ),
                              ],
                              child: const Icon(
                                Icons.more_vert_rounded,
                              ),
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
                    SportlyButton.solid(
                      label: LocaleKeys.teams_page_join.tr(),
                      onTap: () => AutoRouter.of(context).push(
                        const JoinTeamPageRoute(),
                      ),
                    ),
                    const Gap(AppDimens.xsm),
                    SportlyButton.outlined(
                      label: LocaleKeys.teams_page_create.tr(),
                      onTap: () => AutoRouter.of(context).push(
                        const CreateTeamPageRoute(),
                      ),
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
