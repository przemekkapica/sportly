import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_cubit.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_state.f.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/role_badge.dart';
import 'package:sportly/presentation/widgets/show_leave_team_dialog.dart';
import 'package:sportly/presentation/widgets/sport_discipline_icon.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_divider.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_icon_button.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
import 'package:sportly/utils/extensions/date_time_extension.dart';
import 'package:sportly/utils/extensions/string_extension.dart';

class TeamDetailsPage extends HookWidget {
  const TeamDetailsPage({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  final int teamId;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<TeamDetailsPageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init(teamId);
      },
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.map(
        idle: (state) {
          return _Idle(
            state: state,
            cubit: cubit,
          );
        },
        loading: (_) => const SportlyLoader(),
        error: (_) => const SportlyError(),
      ),
    );
  }
}

class _Idle extends StatelessWidget {
  const _Idle({
    Key? key,
    required this.state,
    required this.cubit,
  }) : super(key: key);

  final TeamDetailsPageStateIdle state;
  final TeamDetailsPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state.teamDetails.type == TeamType.professional)
                    ClipRRect(
                      child: Banner(
                        message: 'PRO',
                        textStyle: AppTypo.banner,
                        location: BannerLocation.topEnd,
                        color: AppColors.secondary,
                        child: _TeamDetailsCard(
                          state: state,
                          cubit: cubit,
                        ),
                      ),
                    )
                  else
                    _TeamDetailsCard(
                      state: state,
                      cubit: cubit,
                    ),
                  const Gap(AppDimens.big),
                ],
              ),
            ),
          ),
          Column(
            children: [
              if (state.teamDetails.role.isAdmin) ...[
                SportlyButton.solid(
                  label: LocaleKeys.team_details_manage.tr(),
                  onTap: () => context.router.push(
                    TeamManagementPageRoute(teamId: state.teamDetails.id),
                  ),
                ),
                const Gap(AppDimens.sm),
              ],
              SportlyButton.danger(
                label: LocaleKeys.team_details_leave.tr(),
                onTap: () => showLeaveTeamDialog(
                  context,
                  state.teamDetails.name,
                  () => cubit.leaveTeam(state.teamDetails.id),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamDetailsCard extends StatelessWidget {
  const _TeamDetailsCard({
    Key? key,
    required this.state,
    required this.cubit,
  }) : super(key: key);

  final TeamDetailsPageStateIdle state;
  final TeamDetailsPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SportlyCard(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TeamDetailsHeader(idle: state),
          if (!state.teamDetails.location.nullOrEmpty ||
              !state.teamDetails.organizationName.nullOrEmpty)
            _AdditionalInfoSection(state: state),
          const Gap(AppDimens.md),
          _QuickActionsSection(
            team: Team.fromDetails(state.teamDetails),
            cubit: cubit,
          ),
          const Gap(AppDimens.xbig),
          _TeamMembersSection(idle: state),
        ],
      ),
    );
  }
}

class _AdditionalInfoSection extends StatelessWidget {
  const _AdditionalInfoSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TeamDetailsPageStateIdle state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(AppDimens.sm),
        if (!state.teamDetails.location.nullOrEmpty)
          Row(
            children: [
              const Icon(Icons.location_on),
              const Gap(AppDimens.xsm),
              Text(
                state.teamDetails.location!,
                style: AppTypo.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        if (!state.teamDetails.organizationName.nullOrEmpty) ...[
          const Gap(AppDimens.xxsm),
          Row(
            children: [
              const Icon(Icons.villa),
              const Gap(AppDimens.xsm),
              Text(
                state.teamDetails.organizationName!,
                style: AppTypo.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _TeamMembersSection extends StatelessWidget {
  const _TeamMembersSection({
    Key? key,
    required this.idle,
  }) : super(key: key);

  final TeamDetailsPageStateIdle idle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.team_details_members.tr(),
          style: AppTypo.bodyLarge,
        ),
        const Gap(AppDimens.xxsm),
        const SportlyDivider(),
        const Gap(AppDimens.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final member = idle.teamDetails.members[index];

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.fullName,
                  style: AppTypo.bodySmall,
                ),
                if (member.role.isAdminOrAssistant) ...[
                  const Gap(AppDimens.xxsm),
                  RoleBadge(role: member.role),
                ]
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Gap(AppDimens.xsm);
          },
          itemCount: idle.teamDetails.members.length,
        ),
      ],
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection({
    Key? key,
    required this.team,
    required this.cubit,
  }) : super(key: key);

  final Team team;
  final TeamDetailsPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.team_details_quick_actions.tr(),
          style: AppTypo.bodyLarge,
        ),
        const Gap(AppDimens.xxsm),
        const SportlyDivider(),
        const Gap(AppDimens.sm),
        Row(
          children: [
            SportlyIconButton(
              icon: Icons.chat,
              onTap: () async {
                cubit.updateSelectedChatTeam(team);
                await context.router.navigate(
                  ChatRouter(
                    children: [
                      const ChatEntryPageRoute(),
                      ChatPageRoute(teamId: team.id)
                    ],
                  ),
                );
              },
            ),
            const Gap(AppDimens.sm),
            SportlyIconButton(
              icon: Icons.calendar_month_rounded,
              onTap: () {
                cubit.updateSelectedScheduleTeam(team);
                context.router.navigate(
                  ScheduleRouter(
                    children: [
                      const ScheduleEntryPageRoute(),
                      SchedulePageRoute(team: team),
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            SportlyIconButton(
              icon: Icons.share,
              onTap: () => context.router.push(
                ShareInvitationCodePageRoute(team: team),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TeamDetailsHeader extends StatelessWidget {
  const _TeamDetailsHeader({
    Key? key,
    required this.idle,
  }) : super(key: key);

  final TeamDetailsPageStateIdle idle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SportDisciplineIcon(
          discipline: SportDiscipline(name: idle.teamDetails.discipline.name),
          size: AppDimens.disciplineBiggerIconSize,
        ),
        const Gap(AppDimens.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                idle.teamDetails.name,
                style: AppTypo.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const Gap(AppDimens.xsm),
              Text(
                LocaleKeys.team_details_description.tr(
                  args: [
                    idle.teamDetails.joinedDate.formatMMMMDDYYYY().toString()
                  ],
                ),
                style: AppTypo.bodySmall.copyWith(color: AppColors.secondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
