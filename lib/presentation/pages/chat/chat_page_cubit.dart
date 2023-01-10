import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/chat/mappers/message_mapper.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';
import 'package:sportly/domain/use_cases/get_messages_stream_use_case.dart';
import 'package:sportly/domain/use_cases/get_messages_use_case.dart';
import 'package:sportly/domain/use_cases/get_user_data_use_case.dart';
import 'package:sportly/domain/use_cases/send_message_use_case.dart';
import 'package:sportly/domain/use_cases/start_checking_messages_use_case.dart';
import 'package:sportly/domain/use_cases/stop_checking_messages_use_case.dart';
import 'package:sportly/presentation/pages/chat/chat_page_state.f.dart';

@injectable
class ChatPageCubit extends Cubit<ChatPageState> {
  ChatPageCubit(
    this._getMessagesUseCase,
    this._sendMessageUseCase,
    this._getUserDataUseCase,
    this._getMessagesStreamUseCase,
    this._startCheckingMessagesUseCase,
    this._stopCheckingMessagesUseCase,
    this._messageMapper,
  ) : super(const ChatPageState.loading());

  final GetMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final GetMessagesStreamUseCase _getMessagesStreamUseCase;
  final StartCheckingMessagesUseCase _startCheckingMessagesUseCase;
  final StopCheckingMessagesUseCase _stopCheckingMessagesUseCase;
  final MessageMapper _messageMapper;

  late final int _teamId;
  late final String _userId;

  late final StreamSubscription _messagesSubscription;

  void init(int teamId) async {
    _teamId = teamId;

    try {
      final messages = await _getMessagesUseCase(_teamId);
      final userData = await _getUserDataUseCase();
      _userId = userData.id;

      _startCheckingMessagesUseCase(_teamId);

      _messagesSubscription =
          _getMessagesStreamUseCase().distinct().listen(_refreshMessages);

      emit(ChatPageState.idle(messages: messages, userId: _userId));
    } catch (e) {
      log(e.toString());
      emit(const ChatPageState.error());
    }
  }

  void _refreshMessages(List<Message>? newMessages) async {
    try {
      if (newMessages != null) {
        final messages =
            newMessages.map((message) => _messageMapper(message)).toList();
        emit(ChatPageState.idle(messages: messages, userId: _userId));
      } else {
        final messages = await _getMessagesUseCase(_teamId);
        emit(ChatPageState.idle(messages: messages, userId: _userId));
      }
    } catch (e) {
      log(e.toString());
      emit(const ChatPageState.error());
    }
  }

  Future<void> sendMessage(String message) async {
    await _sendMessageUseCase(_teamId, message);
    _refreshMessages(null);
  }

  @override
  Future<void> close() async {
    _stopCheckingMessagesUseCase();
    _messagesSubscription.cancel();
    super.close();
  }
}
