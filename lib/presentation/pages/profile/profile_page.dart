import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/profile/profile_page_action.f.dart';
import 'package:sportly/presentation/pages/profile/profile_page_cubit.dart';
import 'package:sportly/presentation/pages/profile/profile_page_state.f.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';

class ProfilePage extends HookWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<ProfilePageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(() {
      cubit.init();
    });

    useActionListener<ProfilePageAction>(
      cubit,
      (action) {
        action.whenOrNull(
          signOut: () {
            context.router.replace(const SignInPageRoute());
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: state.map(
        idle: (state) => _Idle(
          state: state,
          cubit: cubit,
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
    required this.state,
    required this.cubit,
  }) : super(key: key);

  final ProfilePageStateIdle state;
  final ProfilePageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          GestureDetector(
            onDoubleTap: cubit.copyIdTokenToClipboard,
            child: _Avatar(state: state),
          ),
          const Gap(AppDimens.big),
          Text(
            state.user.displayName,
            style: AppTypo.titleMedium,
          ),
          const Gap(AppDimens.xsm),
          Text(
            state.user.email,
            style: AppTypo.bodyMedium.copyWith(
              color: AppColors.secondary,
            ),
          ),
          const Spacer(),
          SportlyButton.solid(
            key: const Key('sign-out-button'),
            label: LocaleKeys.sign_out_button_label.tr(),
            onTap: cubit.signOut,
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    Key? key,
    required this.state,
  }) : super(key: key);

  final ProfilePageStateIdle state;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius),
      ),
      child: state.user.photoUrl != null
          ? Image.network(
              state.user.photoUrl!,
              width: AppDimens.huge,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SportlyLoader();
              },
            )
          : Container(
              color: AppColors.team2.withAlpha(160),
            ),
    );
  }
}
