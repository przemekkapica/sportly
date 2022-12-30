import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sportly/domain/features/chat/mappers/message_mapper.dart';
import 'package:sportly/presentation/pages/chat/chat_page_cubit.dart';
import 'package:sportly/presentation/theme/chat_theme.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
import 'package:uuid/uuid.dart';

typedef ChatMessage = types.Message;
typedef TextMessage = types.TextMessage;

class ChatPage extends HookWidget {
  const ChatPage({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  final int teamId;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<ChatPageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init(teamId);
      },
      [],
    );

    return Scaffold(
      body: state.maybeMap(
        idle: (idle) => Chat(
          messages: idle.messages,
          onAttachmentPressed: () {},
          onMessageTap: (_, __) {},
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: (partialText) {
            cubit.sendMessage(partialText.text);
          },
          showUserAvatars: true,
          showUserNames: true,
          user: types.User(id: '1'),
          scrollPhysics: const BouncingScrollPhysics(),
          theme: const SportlyChatTheme(),
        ),
        loading: (_) => const SportlyLoader(),
        error: (_) => const SportlyError(),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  void _handleAttachmentPressed() {
    return;
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    // final index = _messages.indexWhere((element) => element.id == message.id);
    // final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
    //   previewData: previewData,
    // );

    // setState(() {
    //   _messages[index] = updatedMessage;
    // });
  }

  // void _handleSendPressed(types.PartialText message) {
  //   cubit
  //   final textMessage = types.TextMessage(
  //     author: _user,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     id: const Uuid().v4(),
  //     text: message.text,
  //   );

  //   _addMessage(textMessage);
  // }

  // void _loadMessages() async {
  //   final response = await rootBundle.loadString('assets/messages.json');
  //   final messages = (jsonDecode(response) as List)
  //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //       .toList();

  //   setState(() {
  //     _messages = messages;
  //   });
  // }
}
