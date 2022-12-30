import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/pages/chat/chat_page_cubit.dart';
import 'package:sportly/presentation/theme/chat_theme.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';

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
          onPreviewDataFetched: (_, __) {},
          onSendPressed: (partialText) {
            cubit.sendMessage(partialText.text);
          },
          showUserAvatars: true,
          showUserNames: true,
          user: types.User(id: idle.userId),
          scrollPhysics: const BouncingScrollPhysics(),
          theme: const SportlyChatTheme(),
        ),
        loading: (_) => const SportlyLoader(),
        error: (_) => const SportlyError(),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
