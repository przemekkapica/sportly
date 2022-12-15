import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/invitation_code.f.dart';
import 'package:sportly/domain/use_cases/get_invitation_code_use_case.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitation_code_page_state.f.dart';

@injectable
class ShareInvitationPageCubit extends Cubit<ShareInvitationCodePageState> {
  ShareInvitationPageCubit(
    this._getInvitationCodeUseCase,
  ) : super(const ShareInvitationCodePageState.loading());

  final GetInvitationCodeUseCase _getInvitationCodeUseCase;

  late final InvitationCode _generatedCode;

  Future<void> init(int teamId) async {
    try {
      final code = await _getInvitationCodeUseCase(teamId);

      _generatedCode = code;

      emit(
        ShareInvitationCodePageState.idle(
          code: _generatedCode,
        ),
      );
    } catch (e) {
      emit(const ShareInvitationCodePageState.error());
    }
  }

  Future<void> copyToClipboard() async {
    ClipboardData data = ClipboardData(text: _generatedCode.code);

    await Clipboard.setData(data);
  }
}
