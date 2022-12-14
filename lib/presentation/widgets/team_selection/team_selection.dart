import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/role_badge.dart';
import 'package:sportly/presentation/widgets/show_leave_team_dialog.dart';
import 'package:sportly/presentation/widgets/sport_discipline_icon.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
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
    );

    useOnAppLifecycleStateChange((previous, current) {
      if (current == AppLifecycleState.resumed) {
        cubit.startCheckingGetTeams();
      } else {
        cubit.stopCheckingGetTeams();
      }
    });

    return state.map(
      noTeams: (_) {
        return _NoTeams(
          entryPage: entryPage,
        );
      },
      idle: (state) {
        return _Idle(
          state: state,
          cubit: cubit,
          entryPage: entryPage,
        );
      },
      error: (_) => const SportlyError(),
      loading: (_) => const SportlyLoader(),
    );
  }
}

class _Idle extends StatelessWidget {
  const _Idle({
    Key? key,
    required this.state,
    required this.cubit,
    required this.entryPage,
  }) : super(key: key);

  final TeamSelectionStateIdle state;
  final TeamSelectionCubit cubit;
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
                final team = state.teams[index];

                return GestureDetector(
                  onDoubleTap: () {
                    if (entryPage == EntryPage.teams) {
                      cubit.deleteTeam(team.id);
                    }
                  },
                  onTap: () {
                    switch (entryPage) {
                      case EntryPage.teams:
                        context.router.push(
                          TeamDetailsPageRoute(teamId: team.id),
                        );
                        break;
                      case EntryPage.chat:
                        cubit.updateSelectedChatTeam(team);
                        context.router.push(
                          ChatPageRoute(teamId: team.id),
                        );
                        break;
                      case EntryPage.schedule:
                        cubit.updateSelectedScheduleTeam(team);
                        context.router.push(
                          SchedulePageRoute(team: team),
                        );
                        break;
                    }
                  },
                  child: SportlyCard(
                    content: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SportDisciplineIcon(
                          discipline: team.discipline,
                          size: AppDimens.disciplineIconSize,
                        ),
                        const Gap(AppDimens.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                team.name,
                                style: AppTypo.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const Gap(AppDimens.xxsm),
                              Text(
                                team.membersCount.toString() +
                                    LocaleKeys.team_selection_members.tr(),
                                style: AppTypo.labelLarge,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (entryPage == EntryPage.teams)
                              _PopupMenuButton(
                                state: state,
                                entryPage: entryPage,
                                cubit: cubit,
                                index: index,
                              ),
                            if (entryPage == EntryPage.teams &&
                                team.role.isAdminOrAssistant) ...[
                              const Gap(AppDimens.xbig),
                              RoleBadge(role: team.role)
                            ]
                          ],
                        ),
                      ],
                    ),
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
                  onTap: () => context.router.push(
                    const JoinTeamPageRoute(),
                  ),
                ),
                const Gap(AppDimens.xsm),
                SportlyButton.outlined(
                  label: LocaleKeys.team_selection_create.tr(),
                  onTap: () => context.router.push(
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

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton({
    Key? key,
    required this.state,
    required this.entryPage,
    required this.cubit,
    required this.index,
  }) : super(key: key);

  final TeamSelectionStateIdle state;
  final EntryPage entryPage;
  final TeamSelectionCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    final team = state.teams[index];

    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimens.borderRadius),
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        if (team.role.isAdmin)
          PopupMenuItem(
            child: Text(
              LocaleKeys.team_selection_menu_manage.tr(),
              style: AppTypo.bodySmall,
            ),
            onTap: () {
              if (entryPage == EntryPage.teams) {
                context.router.push(
                  TeamManagementPageRoute(teamId: team.id),
                );
              } else {
                context.router.navigate(
                  TeamsRouter(
                    children: [
                      TeamManagementPageRoute(teamId: team.id),
                    ],
                  ),
                );
              }
            },
          ),
        PopupMenuItem(
          child: Text(
            LocaleKeys.team_selection_menu_invite.tr(),
            style: AppTypo.bodySmall,
          ),
          onTap: () {
            if (entryPage == EntryPage.teams) {
              context.router.push(
                ShareInvitationCodePageRoute(
                  team: team,
                ),
              );
            } else {
              context.router.navigate(
                TeamsRouter(
                  children: [
                    ShareInvitationCodePageRoute(
                      team: team,
                    ),
                  ],
                ),
              );
            }
          },
        ),
        PopupMenuItem(
          child: Text(
            LocaleKeys.team_selection_menu_leave.tr(),
            style: AppTypo.bodySmall.copyWith(
              color: AppColors.danger,
            ),
          ),
          onTap: () => showLeaveTeamDialog(
            context,
            team.name,
            () => cubit.leaveTeam(team.id),
          ),
        ),
      ],
      child: const Icon(
        Icons.more_vert_rounded,
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
              onTap: () {
                if (entryPage == EntryPage.teams) {
                  context.router.push(
                    const JoinTeamPageRoute(),
                  );
                } else {
                  context.router.navigate(
                    const TeamsRouter(children: [JoinTeamPageRoute()]),
                  );
                }
              },
            ),
            const Gap(AppDimens.xsm),
            SportlyButton.outlined(
              label: LocaleKeys.team_selection_create.tr(),
              onTap: () {
                if (entryPage == EntryPage.teams) {
                  context.router.push(
                    const CreateTeamPageRoute(),
                  );
                } else {
                  context.router.navigate(
                    const TeamsRouter(children: [CreateTeamPageRoute()]),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
