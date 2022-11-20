import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page_action.f.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page_cubit.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page_state.f.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/form/sportly_dropdown.dart';
import 'package:sportly/presentation/widgets/form/sportly_radio_button.dart';
import 'package:sportly/presentation/widgets/form/sportly_text_input.dart';
import 'package:sportly/presentation/widgets/scroll_or_fit_bottom.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';

const List<String> disciplines = <String>[
  'Football',
  'Basketball',
  'Tennis',
  'Handball'
];

class CreateTeamPage extends HookWidget {
  const CreateTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<CreateTeamPageCubit>();
    final state = useCubitBuilder(cubit);

    useActionListener<CreateTeamPageAction>(cubit, (action) {
      action.whenOrNull(
        showLoader: context.loaderOverlay.show,
        hideLoader: context.loaderOverlay.hide,
        success: () {
          showSnackBar(
            context,
            'Team created successfully',
            SnackbarPurpose.success,
          );
          context.router.pop();
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.map(
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
        ),
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

  final CreateTeamPageCubit cubit;
  final CreateTeamPageStateIdle state;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final teamType = useState(TeamType.professional);
    final scrollController = useScrollController();

    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: ScrollOrFitBottom(
        controller: scrollController,
        scrollableContent: [
          Form(
            key: formKey,
            child: Column(
              children: [
                SportlyCard(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.big,
                    horizontal: AppDimens.sm,
                  ),
                  borderColor: AppColors.secondary.withAlpha(80),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.create_team_team_type.tr(),
                        style: AppTypo.bodySmall,
                      ),
                      const Gap(AppDimens.sm),
                      Row(
                        children: <Widget>[
                          SportlyRadioButton(
                            value: TeamType.professional,
                            groupValue: teamType.value,
                            label: LocaleKeys.create_team_professional.tr(),
                            onChanged: (TeamType? value) {
                              if (value != null) {
                                teamType.value = value;
                              }
                              cubit.onTeamTypeChanged(value);
                            },
                          ),
                          const Gap(AppDimens.xbig),
                          SportlyRadioButton(
                            value: TeamType.amateur,
                            groupValue: teamType.value,
                            label: LocaleKeys.create_team_amateur.tr(),
                            onChanged: (TeamType? value) {
                              if (value != null) {
                                teamType.value = value;
                              }
                              cubit.onTeamTypeChanged(value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(AppDimens.md),
                SportlyTextInput(
                  label: LocaleKeys.create_team_team_name.tr(),
                  textInputAction: TextInputAction.next,
                  onChanged: cubit.onTeamNameChanged,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.create_team_team_name_error.tr();
                    }
                    return null;
                  },
                ),
                const Gap(AppDimens.md),
                SportlyDropdown<SportDiscipline>(
                  hintText: LocaleKeys.create_team_discipline.tr(),
                  validator: (value) {
                    if (value == null || value.name.isEmpty) {
                      return LocaleKeys.create_team_discipline_error.tr();
                    }
                    return null;
                  },
                  items: disciplines
                      .map<DropdownMenuItem<SportDiscipline>>((String value) {
                    return DropdownMenuItem<SportDiscipline>(
                      value: SportDiscipline(name: value),
                      child: Text(
                        value,
                        style: AppTypo.bodySmall,
                      ),
                    );
                  }).toList(),
                  onChanged: cubit.onSportDisciplineChanged,
                ),
                const Gap(AppDimens.md),
                SportlyTextInput(
                  label: LocaleKeys.create_team_location.tr(),
                  textInputAction: TextInputAction.next,
                  onChanged: cubit.onLocationChanged,
                  validator: (_) => null,
                ),
                const Gap(AppDimens.md),
                SportlyTextInput(
                  label: LocaleKeys.create_team_organization_name.tr(),
                  textInputAction: TextInputAction.done,
                  onChanged: cubit.onOrganizationNameChanged,
                  validator: (_) => null,
                ),
                const Gap(AppDimens.xbig),
              ],
            ),
          ),
        ],
        bottomContent: SportlyButton.solid(
          enabled: state.submitButtonEnabled,
          onTap: () {
            if (formKey.currentState!.validate()) {
              cubit.submit();
            }
          },
          label: LocaleKeys.create_team_button_label.tr(),
        ),
      ),
    );
  }
}
