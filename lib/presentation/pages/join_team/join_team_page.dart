import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/join_team/join_team_page_action.f.dart';
import 'package:sportly/presentation/pages/join_team/join_team_page_cubit.dart';
import 'package:sportly/presentation/pages/join_team/join_team_page_state.f.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/form/sportly_pin_input.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/show_sportly_dialog.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';

class JoinTeamPage extends HookWidget {
  const JoinTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<JoinTeamPageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [],
    );

    useActionListener<JoinTeamPageAction>(
      cubit,
      (action) {
        action.whenOrNull(
          alreadyInTeam: () {},
          addedToTeam: () {
            showSnackBar(context, 'You have been added to the new team');
            Navigator.of(context).pop();
          },
          wrongCode: () {
            showSportlyDialog(
              context,
              Text('Invalid code'),
              Text('The code you entered is either wrong or expired'),
              [],
            );
          },
        );
      },
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.maybeMap(
        idle: (state) => _Idle(
          state: state,
          cubit: cubit,
        ),
        loading: (_) => const SportlyLoader(),
        orElse: () => const SizedBox.shrink(),
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

  final JoinTeamPageStateIdle state;
  final JoinTeamPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: (Center(
        child: SportlyCard(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.big,
            horizontal: AppDimens.sm,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.join_team_title.tr(),
                style: AppTypo.titleSmall,
                textAlign: TextAlign.center,
              ),
              const Gap(AppDimens.lg),
              SportlyPinInput(
                errorText: '',
                onChanged: cubit.onChanged,
              ),
              const Gap(AppDimens.xlg),
              SportlyButton.solid(
                label: LocaleKeys.join_team_button_label.tr(),
                enabled: state.canSubmit,
                onTap: cubit.submit,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
