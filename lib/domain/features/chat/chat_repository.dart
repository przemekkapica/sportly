import 'package:sportly/domain/auth/models/internal_user.f.dart';
import 'package:sportly/domain/features/chat/models/message.f.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages(int teamId);

  Future<void> sendMessage(int teamId, String message);

  Future<InternalUser> getUserData();
}
