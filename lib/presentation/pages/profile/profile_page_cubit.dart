import 'package:flutter/services.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_current_user_use_case.dart';
import 'package:sportly/domain/use_cases/get_id_token_use_case.dart';
import 'package:sportly/domain/use_cases/sign_out_use_case.dart';
import 'package:sportly/presentation/pages/profile/profile_page_action.f.dart';
import 'package:sportly/presentation/pages/profile/profile_page_state.f.dart';

@injectable
class ProfilePageCubit
    extends ActionCubit<ProfilePageState, ProfilePageAction> {
  ProfilePageCubit(
    this._getCurrentUserUseCase,
    this._signOutUseCase,
    this._getIdTokenUseCase,
  ) : super(const ProfilePageState.loading());

  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetIdTokenUseCase _getIdTokenUseCase;

  void init() {
    try {
      final user = _getCurrentUserUseCase();
      if (user == null) {
        emit(const ProfilePageState.error());

        return;
      }
      emit(ProfilePageState.idle(user: user));
    } catch (e) {
      emit(const ProfilePageState.error());
    }
  }

  Future<void> signOut() async {
    try {
      await _signOutUseCase();

      dispatch(const ProfilePageAction.signOut());
    } catch (e) {
      emit(const ProfilePageState.error());
    }
  }

  Future<void> copyIdTokenToClipboard() async {
    final idToken = await _getIdTokenUseCase();
    ClipboardData data = ClipboardData(text: idToken);

    await Clipboard.setData(data);
  }
}
