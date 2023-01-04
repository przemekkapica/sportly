import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page_action.f.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page_cubit.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_assets.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/widgets/app_logo.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';

class SignInPage extends HookWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<SignInPageCubit>();
    final state = useCubitBuilder(cubit);

    useActionListener<SignInPageAction>(
      cubit,
      (action) {
        action.map(
          authSuccess: (_) => context.router.replace(
            const HomePageRoute(),
          ),
          authError: (_) => context.router.replace(
            const AuthErrorPageRoute(),
          ),
        );
      },
    );

    return Scaffold(
      body: state.map(
        idle: (_) {
          return Padding(
            padding: const EdgeInsets.all(AppDimens.sm),
            child: Column(
              children: [
                const Spacer(),
                const AppLogo(),
                const Spacer(),
                SportlyButton.solid(
                  key: const Key('sign-in-button'),
                  label: LocaleKeys.sign_in_page_button_label.tr(),
                  assetPath: AppAssets.googleIcon,
                  onTap: cubit.signInWithGoogle,
                ),
                const Gap(AppDimens.md),
              ],
            ),
          );
        },
        loading: (_) {
          return const SportlyLoader();
        },
      ),
    );
  }
}
