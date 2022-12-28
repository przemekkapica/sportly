import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';

part 'home_page_state.f.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.idle({
    required Team? selectedTeam,
  }) = HomePageStateIdle;
}
