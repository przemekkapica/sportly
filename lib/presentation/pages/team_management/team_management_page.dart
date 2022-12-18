import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/team_management/team_management_page_action.f.dart';
import 'package:sportly/presentation/pages/team_management/team_management_page_cubit.dart';
import 'package:sportly/presentation/pages/team_management/team_management_page_state.f.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/admin_badge.dart';
import 'package:sportly/presentation/widgets/form/sportly_text_input.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_divider.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';

class TeamManagementPage extends HookWidget {
  const TeamManagementPage({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  final int teamId;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<TeamManagementPageCubit>();
    final state = useCubitBuilder(cubit);

    useActionListener<TeamManagementPageAction>(cubit, (action) {
      action.whenOrNull(
        showLoader: context.loaderOverlay.show,
        hideLoader: context.loaderOverlay.hide,
        success: () {
          showSnackBar(
            context,
            'Team updated successfully',
            SnackbarPurpose.success,
          );
        },
      );
    });

    useEffect(
      () {
        cubit.init(teamId);
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.map(
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
        ),
        loading: (_) => const SportlyLoader(),
        error: (_) => const SportlyError(),
      ),
    );
  }
}

class _Idle extends HookWidget {
  const _Idle({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  final TeamManagementPageCubit cubit;
  final TeamManagementPageStateIdle state;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(AppDimens.xsm),
                  SportlyTextInput(
                    label: LocaleKeys.team_management_team_name.tr(),
                    initialValue: state.teamDetails.name,
                    textInputAction: TextInputAction.next,
                    onChanged: cubit.onTeamNameChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.team_management_team_name_error.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(AppDimens.md),
                  SportlyTextInput(
                    label: LocaleKeys.team_management_location.tr(),
                    initialValue: state.teamDetails.location,
                    textInputAction: TextInputAction.next,
                    onChanged: cubit.onLocationChanged,
                    validator: (_) => null,
                  ),
                  const Gap(AppDimens.md),
                  SportlyTextInput(
                    label: LocaleKeys.team_management_organization_name.tr(),
                    initialValue: state.teamDetails.organizationName,
                    textInputAction: TextInputAction.done,
                    onChanged: cubit.onOrganizationNameChanged,
                    validator: (_) => null,
                  ),
                  const Gap(AppDimens.xbig),
                ],
              ),
            ),
            SportlyButton.solid(
              enabled: state.submitButtonEnabled,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  cubit.submit();
                }
              },
              label: LocaleKeys.team_management_button_label.tr(),
            ),
            const Gap(AppDimens.xbig),
            SportlyCard(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.team_management_members.tr(),
                    style: AppTypo.bodyLarge,
                  ),
                  const Gap(AppDimens.xxsm),
                  const SportlyDivider(),
                  const Gap(AppDimens.md),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final member = state.teamDetails.members[index];

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.fullName,
                            style: AppTypo.bodySmall,
                          ),
                          if (member.role.isAdmin) ...[
                            const Gap(AppDimens.xxsm),
                            const AdminBadge(),
                          ],
                          const Spacer(),
                          if (state.teamDetails.members.length > 1)
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
                                    LocaleKeys.team_management_make_admin.tr(),
                                    style: AppTypo.bodySmall,
                                  ),
                                  onTap: () {},
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    LocaleKeys.team_management_remove.tr(),
                                    style: AppTypo.bodySmall.copyWith(
                                      color: AppColors.danger,
                                    ),
                                  ),
                                  onTap: () =>
                                      cubit.removeTeamMember(member.id),
                                ),
                              ],
                              child: const Icon(
                                Icons.more_vert_rounded,
                              ),
                            )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Gap(AppDimens.sm);
                    },
                    itemCount: state.teamDetails.members.length,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
