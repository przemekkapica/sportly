import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitaion_code_page.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_cubit.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_state.f.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_divider.dart';
import 'package:sportly/presentation/widgets/sportly_icon_button.dart';
import 'package:sportly/utils/extensions/date_time_extension.dart';

class TeamDetailsPage extends HookWidget {
  const TeamDetailsPage({
    Key? key,
    required this.teamId,
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.maybeMap(
          idle: (state) {
            return Padding(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SportlyCard(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _TeamDetailsHeader(idle: state),
                                const Gap(AppDimens.big),
                                const _QuickActionsSection(),
                                const Gap(AppDimens.xbig),
                                _TeamMembersSection(idle: state),
                              ],
                            ),
                          ),
                          const Gap(AppDimens.big),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SportlyButton.solid(
                        label: 'Manage',
                        onTap: () {},
                      ),
                      const Gap(AppDimens.sm),
                      SportlyButton.danger(
                        label: 'Leave team',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink()),
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

            return Text(
              member.fullName,
              style: AppTypo.bodySmall.copyWith(
                color: member.isAdmin ? AppColors.primary : AppColors.secondary,
              ),
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
  }) : super(key: key);

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
              onTap: () => AutoRouter.of(context).navigate(
                const ChatPageRoute(),
              ),
            ),
            const Gap(AppDimens.sm),
            SportlyIconButton(
              icon: Icons.calendar_month_rounded,
              onTap: () => AutoRouter.of(context).navigate(
                const SchedulePageRoute(),
              ),
            ),
            const Spacer(),
            SportlyIconButton(
              icon: Icons.share,
              onTap: () => AutoRouter.of(context).push(
                const ShareInvitationCodePageRoute(),
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
        Container(
          decoration: BoxDecoration(
            color: AppColors.team1.withAlpha(160),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimens.borderRadius),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(AppDimens.xsm),
            child: Icon(
              Icons.sports_soccer_rounded,
              size: 70,
            ),
          ),
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
                    idle.teamDetails.joinedDate.formatDMMYYYY().toString()
                  ],
                ),
                style: AppTypo.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
