import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/edit_event/update_event_page_action.f.dart';
import 'package:sportly/presentation/pages/edit_event/update_event_page_cubit.dart';
import 'package:sportly/presentation/pages/edit_event/update_event_page_state.f.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/form/sportly_text_input.dart';
import 'package:sportly/presentation/widgets/scroll_or_fit_bottom.dart';
import 'package:sportly/presentation/widgets/show_date_time_picker.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
import 'package:sportly/utils/extensions/date_time_extension.dart';
import 'package:sportly/utils/extensions/string_extension.dart';

class UpdateEventPage extends HookWidget {
  const UpdateEventPage({
    Key? key,
    required this.teamId,
    required this.event,
  }) : super(key: key);

  final int teamId;
  final Event event;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<UpdateEventPageCubit>();
    final state = useCubitBuilder(cubit);

    useActionListener<UpdateEventPageAction>(cubit, (action) {
      action.whenOrNull(
        showLoader: context.loaderOverlay.show,
        hideLoader: context.loaderOverlay.hide,
        success: () {
          showSnackBar(
            context,
            LocaleKeys.edit_event_success.tr(),
            SnackbarPurpose.success,
          );
          context.router.pop(true);
        },
      );
    });

    useEffect(
      () {
        cubit.init(teamId, event);
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.map(
        error: (_) => const SportlyError(),
        loading: (_) => const SportlyLoader(),
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
          initialDate: event.date,
        ),
      ),
    );
  }
}

class _Idle extends HookWidget {
  const _Idle({
    Key? key,
    required this.cubit,
    required this.state,
    required this.initialDate,
  }) : super(key: key);

  final UpdateEventPageCubit cubit;
  final UpdateEventPageStateIdle state;
  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
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
                InkWell(
                  onTap: () => showDateTimePicker(
                    context,
                    cubit.onDateChanged,
                    state.selectedDate,
                  ),
                  child: SportlyCard(
                    padding: const EdgeInsets.all(AppDimens.md),
                    borderColor: AppColors.secondary.withAlpha(80),
                    content: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(Icons.calendar_today_rounded),
                            const Gap(AppDimens.xsm),
                            Text(
                              state.selectedDate.formatEEEEMMMdd(),
                              style: AppTypo.bodySmall,
                            ),
                          ],
                        ),
                        const Gap(AppDimens.sm),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded),
                            const Gap(AppDimens.xsm),
                            Text(
                              state.selectedDate.formatHHMM(),
                              style: AppTypo.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(AppDimens.md),
                SportlyTextInput(
                  label: LocaleKeys.edit_event_title.tr(),
                  textInputAction: TextInputAction.next,
                  onChanged: cubit.onTitleChanged,
                  initialValue: cubit.title,
                  validator: (value) {
                    if (value.nullOrEmpty) {
                      return LocaleKeys.create_team_team_name_error.tr();
                    }
                    return null;
                  },
                ),
                const Gap(AppDimens.md),
                SportlyTextInput(
                  label: LocaleKeys.edit_event_description.tr(),
                  initialValue: cubit.description,
                  textInputAction: TextInputAction.done,
                  onChanged: cubit.onDescriptionChanged,
                  validator: (_) => null,
                ),
                const Gap(AppDimens.md),
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
          label: LocaleKeys.edit_event_button_label.tr(),
        ),
      ),
    );
  }
}
