import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/chat/dtos/get_messages_dto.dart';

part 'chat_data_source.g.dart';

@RestApi()
@injectable
abstract class ChatDataSource {
  @factoryMethod
  factory ChatDataSource(Dio dio) = _ChatDataSource;

  @GET(NetworkConfig.GET_MESSAGES)
  Future<GetMessagesDto> getMessages(
    @Path() int teamId,
  );

  @POST(NetworkConfig.SEND_MESSAGE)
  Future<void> sendMessage(
    @Path() int teamId,
    @Query('message') String message,
  );
}
