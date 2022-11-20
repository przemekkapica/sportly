import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitation_code_page_cubit.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitation_code_page_state.f.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';

class ShareInvitationCodePage extends HookWidget {
  const ShareInvitationCodePage({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<ShareInvitationPageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.map(
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
          team: team,
        ),
        loading: (_) => const SportlyLoader(),
        error: (_) => const SportlyError(),
      ),
    );
  }
}

class _Idle extends StatelessWidget {
  const _Idle({
    Key? key,
    required this.cubit,
    required this.state,
    required this.team,
  }) : super(key: key);

  final ShareInvitationPageCubit cubit;
  final ShareInvitationCodePageStateIdle state;
  final Team team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Center(
        child: SportlyCard(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.big,
            horizontal: AppDimens.sm,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.share_invitation_code_title.tr(),
                style: AppTypo.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                team.name,
                style: AppTypo.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(AppDimens.xxbig),
              Text(
                state.code,
                style: AppTypo.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                LocaleKeys.share_invitation_code_description.tr(),
                style: AppTypo.labelLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(AppDimens.xxlg),
              SportlyButton.solid(
                label: LocaleKeys.share_invitation_code_button_label.tr(),
                onTap: () {
                  cubit.copyToClipboard();
                  showSnackBar(
                    context,
                    LocaleKeys.share_invitation_code_message.tr(),
                    SnackbarPurpose.info,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
