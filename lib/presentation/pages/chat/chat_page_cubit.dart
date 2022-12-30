import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/mappers/message_mapper.dart';
import 'package:sportly/domain/use_cases/get_messages_use_case.dart';
import 'package:sportly/domain/use_cases/send_message_use_case.dart';
import 'package:sportly/presentation/pages/chat/chat_page_state.f.dart';

@injectable
class ChatPageCubit extends Cubit<ChatPageState> {
  ChatPageCubit(
    this._getMessagesUseCase,
    this._sendMessageUseCase,
  ) : super(const ChatPageState.loading());

  final GetMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  late final int _teamId;

  void init(int teamId) async {
    _teamId = teamId;
    try {
      final messages = await _getMessagesUseCase(_teamId);
      emit(ChatPageState.idle(messages: messages));
    } catch (e) {
      log(e.toString());
      emit(const ChatPageState.error());
    }
  }

  void refreshMessages() async {
    try {
      final messages = await _getMessagesUseCase(_teamId);
      emit(ChatPageState.idle(messages: messages));
    } catch (e) {
      log(e.toString());
      emit(const ChatPageState.error());
    }
  }

  Future<void> sendMessage(String message) async {
    await _sendMessageUseCase(_teamId, message);
    refreshMessages();
  }
}
