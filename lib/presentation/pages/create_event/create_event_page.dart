import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/create_event/create_event_page_action.f.dart';
import 'package:sportly/presentation/pages/create_event/create_event_page_cubit.dart';
import 'package:sportly/presentation/pages/create_event/create_event_page_state.f.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/widgets/form/sportly_text_input.dart';
import 'package:sportly/presentation/widgets/scroll_or_fit_bottom.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
import 'package:sportly/utils/extensions/string_extension.dart';

class CreateEventPage extends HookWidget {
  const CreateEventPage({
    Key? key,
    required this.teamId,
    required this.date,
  }) : super(key: key);

  final int teamId;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<CreateEventPageCubit>();
    final state = useCubitBuilder(cubit);

    useActionListener<CreateEventPageAction>(cubit, (action) {
      action.whenOrNull(
        showLoader: context.loaderOverlay.show,
        hideLoader: context.loaderOverlay.hide,
        success: () {
          showSnackBar(
            context,
            'Event created successfully',
            SnackbarPurpose.success,
          );
          context.router.pop(true);
        },
      );
    });

    useEffect(
      () {
        cubit.init(teamId, date);
      },
      [],
    );

    return Scaffold(
      body: state.map(
        error: (_) => const SportlyError(),
        loading: (_) => const SportlyLoader(),
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
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
  }) : super(key: key);

  final CreateEventPageCubit cubit;
  final CreateEventPageStateIdle state;

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
                const Gap(AppDimens.md),
                SportlyTextInput(
                  label: 'title*',
                  textInputAction: TextInputAction.next,
                  onChanged: cubit.onTitleChanged,
                  validator: (value) {
                    if (value.nullOrEmpty) {
                      return LocaleKeys.create_team_team_name_error.tr();
                    }
                    return null;
                  },
                ),
                const Gap(AppDimens.md),
                SportlyTextInput(
                  label: 'description',
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
          label: 'Create event',
        ),
      ),
    );
  }
}
