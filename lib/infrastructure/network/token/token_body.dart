import 'package:json_annotation/json_annotation.dart';

part 'token_body.g.dart';

// temporary
@JsonSerializable()
class TokenBody {
  TokenBody({
    required this.idToken,
  });
  final String idToken;

  Map<String, dynamic> toJson() => _$TokenBodyToJson(this);
}
