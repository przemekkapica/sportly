import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_id_token_use_case.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitation_code_page_state.f.dart';

@injectable
class ShareInvitationPageCubit extends Cubit<ShareInvitationCodePageState> {
  ShareInvitationPageCubit(
    this._getIdTokenUseCase,
  ) : super(const ShareInvitationCodePageState.loading());

  final GetIdTokenUseCase _getIdTokenUseCase;
  late final String _generatedCode;

  Future<void> init() async {
    try {
      _generatedCode = '482931';

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
    // ClipboardData data = ClipboardData(text: _generatedCode);
    final token = await _getIdTokenUseCase();
    ClipboardData data = ClipboardData(text: token);

    await Clipboard.setData(data);
  }
}
