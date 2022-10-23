import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/presentation/pages/share_invitation_code/share_invitation_code_page_state.f.dart';

@injectable
class ShareInvitationPageCubit extends Cubit<ShareInvitationCodePageState> {
  ShareInvitationPageCubit()
      : super(const ShareInvitationCodePageState.loading());

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
    ClipboardData data = ClipboardData(text: _generatedCode);

    await Clipboard.setData(data);
  }
}
