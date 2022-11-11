import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sport_discipline_icon.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection_cubit.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection_state.f.dart';

enum EntryPage {
  teams,
  chat,
  schedule,
}

class TeamSelection extends HookWidget {
  const TeamSelection({
    Key? key,
    required this.entryPage,
  }) : super(key: key);

  final EntryPage entryPage;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<TeamSelectionCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [],
    );

    return state.maybeMap(
      noTeams: (_) {
        return _NoTeams(
          entryPage: entryPage,
        );
      },
      idle: (state) {
        return _Idle(
          state: state,
          entryPage: entryPage,
        );
      },
      orElse: () {
        return const SizedBox.shrink();
      },
    );
  }
}

class _Idle extends StatelessWidget {
  const _Idle({
    Key? key,
    required this.state,
    required this.entryPage,
  }) : super(key: key);

  final TeamSelectionStateIdle state;
  final EntryPage entryPage;

  @override
  Widget build(BuildContext context) {
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
                    switch (entryPage) {
                      case EntryPage.teams:
                        AutoRouter.of(context).push(
                          TeamDetailsPageRoute(teamId: state.teams[index].id),
                        );
                        break;
                      case EntryPage.chat:
                        AutoRouter.of(context).push(
                          ChatPageRoute(team: state.teams[index]),
                        );
                        break;
                      case EntryPage.schedule:
                        AutoRouter.of(context).push(
                          SchedulePageRoute(team: state.teams[index]),
                        );
                        break;
                    }
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
                                  LocaleKeys.team_selection_members.tr(),
                              style: AppTypo.labelLarge,
                            ),
                          ],
                        ),
                      ),
                      if (entryPage == EntryPage.teams)
                        PopupMenuButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppDimens.borderRadius),
                            ),
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text(
                                LocaleKeys.team_selection_menu_manage.tr(),
                                style: AppTypo.bodySmall,
                              ),
                            ),
                            PopupMenuItem(
                              child: Text(
                                LocaleKeys.team_selection_menu_invite.tr(),
                                style: AppTypo.bodySmall,
                              ),
                            ),
                            PopupMenuItem(
                              child: Text(
                                LocaleKeys.team_selection_menu_leave.tr(),
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
          if (entryPage == EntryPage.teams) ...[
            Column(
              children: [
                const Gap(AppDimens.sm),
                SportlyButton.solid(
                  label: LocaleKeys.team_selection_join.tr(),
                  onTap: () => AutoRouter.of(context).push(
                    const JoinTeamPageRoute(),
                  ),
                ),
                const Gap(AppDimens.xsm),
                SportlyButton.outlined(
                  label: LocaleKeys.team_selection_create.tr(),
                  onTap: () => AutoRouter.of(context).push(
                    const CreateTeamPageRoute(),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}

class _NoTeams extends StatelessWidget {
  const _NoTeams({
    Key? key,
    required this.entryPage,
  }) : super(key: key);

  final EntryPage entryPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.team_selection_no_teams_title.tr(),
              style: AppTypo.titleLarge,
            ),
            const Gap(AppDimens.sm),
            Text(
              LocaleKeys.team_selection_no_teams_description.tr(),
              style: AppTypo.labelLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(AppDimens.huge),
            SportlyButton.solid(
              label: LocaleKeys.team_selection_join.tr(),
              onTap: () => AutoRouter.of(context).push(
                const JoinTeamPageRoute(),
              ),
            ),
            const Gap(AppDimens.xsm),
            SportlyButton.outlined(
              label: LocaleKeys.team_selection_create.tr(),
              onTap: () => AutoRouter.of(context).push(
                const CreateTeamPageRoute(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
