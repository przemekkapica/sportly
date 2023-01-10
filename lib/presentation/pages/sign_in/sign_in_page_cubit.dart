import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page_action.f.dart';
import 'package:sportly/presentation/pages/sign_in/sign_in_page_state.f.dart';

@injectable
class SignInPageCubit extends ActionCubit<SignInPageState, SignInPageAction> {
  SignInPageCubit(
    this._signInWithGoogle,
  ) : super(const SignInPageState.idle());

  final SignInWithGoogleUseCase _signInWithGoogle;

  Future<void> signInWithGoogle() async {
    emit(const SignInPageState.loading());
    try {
      await _signInWithGoogle();
      dispatch(const SignInPageAction.authSuccess());
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      dispatch(const SignInPageAction.authError());
    }
  }
}
