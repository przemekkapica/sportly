import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/presentation/pages/chat/chat_page_state.f.dart';

@injectable
class ChatPageCubit extends Cubit<ChatPageState> {
  ChatPageCubit() : super(const ChatPageState.loading());

  void init() {
    emit(const ChatPageState.idle());
  }
}
