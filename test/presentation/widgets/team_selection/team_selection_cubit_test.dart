import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/use_cases/delete_team_use_case.dart';
import 'package:sportly/domain/use_cases/fetch_teams_use_case.dart';
import 'package:sportly/domain/use_cases/get_teams_stream_use_case.dart';
import 'package:sportly/domain/use_cases/get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/leave_team_use_case.dart';
import 'package:sportly/domain/use_cases/start_checking_get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/stop_checking_get_teams_use_case.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection_cubit.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection_state.f.dart';

class MockGetTeamsUseCase extends Mock implements GetTeamsUseCase {}

class MockLeaveTeamUseCase extends Mock implements LeaveTeamUseCase {}

class MockStartCheckingGetTeamsUseCase extends Mock
    implements StartCheckingGetTeamsUseCase {}

class MockStopCheckingGetTeamsUseCase extends Mock
    implements StopCheckingGetTeamsUseCase {}

class MockGetTeamsStreamUseCase extends Mock implements GetTeamsStreamUseCase {}

class MockDeleteTeamUseCase extends Mock implements DeleteTeamUseCase {}

class MockFetchTeamsUseCase extends Mock implements FetchTeamsUseCase {}

class MockTeam extends Mock implements Team {}

void main() {
  group('TeamSelectionCubit', () {
    late MockGetTeamsUseCase getTeamsUseCase;
    late MockLeaveTeamUseCase leaveTeamUseCase;
    late MockStartCheckingGetTeamsUseCase startCheckingGetTeamsUseCase;
    late MockStopCheckingGetTeamsUseCase stopCheckingGetTeamsUseCase;
    late MockGetTeamsStreamUseCase getTeamsStreamUseCase;
    late MockDeleteTeamUseCase deleteTeamUseCase;
    late MockFetchTeamsUseCase fetchTeamsUseCase;

    late TeamSelectionCubit cubit;

    late BehaviorSubject<List<Team>> teamsSubject;

    final team = MockTeam();

    setUp(() {
      getTeamsUseCase = MockGetTeamsUseCase();
      leaveTeamUseCase = MockLeaveTeamUseCase();
      startCheckingGetTeamsUseCase = MockStartCheckingGetTeamsUseCase();
      stopCheckingGetTeamsUseCase = MockStopCheckingGetTeamsUseCase();
      getTeamsStreamUseCase = MockGetTeamsStreamUseCase();
      deleteTeamUseCase = MockDeleteTeamUseCase();
      fetchTeamsUseCase = MockFetchTeamsUseCase();

      teamsSubject = BehaviorSubject();

      when(getTeamsStreamUseCase).thenAnswer((_) async* {
        yield* teamsSubject.stream;
      });

      cubit = TeamSelectionCubit(
        getTeamsUseCase,
        leaveTeamUseCase,
        getTeamsStreamUseCase,
        startCheckingGetTeamsUseCase,
        stopCheckingGetTeamsUseCase,
        deleteTeamUseCase,
        fetchTeamsUseCase,
      );
    });

    tearDown(() {
      teamsSubject.close();
      cubit.close();
    });

    TeamSelectionCubit buildCubit() {
      return TeamSelectionCubit(
        getTeamsUseCase,
        leaveTeamUseCase,
        getTeamsStreamUseCase,
        startCheckingGetTeamsUseCase,
        stopCheckingGetTeamsUseCase,
        deleteTeamUseCase,
        fetchTeamsUseCase,
      );
    }

    test('initial state is loading', () {
      expect(cubit.state, const TeamSelectionState.loading());
    });

    blocTest<TeamSelectionCubit, TeamSelectionState>(
      'start checking get teams',
      build: buildCubit,
      act: (cubit) => cubit.startCheckingGetTeams(),
      setUp: () {
        when(startCheckingGetTeamsUseCase).thenAnswer((_) async => {});
      },
      expect: () => [],
      verify: (cubit) {
        verify(startCheckingGetTeamsUseCase).called(1);
      },
    );

    blocTest<TeamSelectionCubit, TeamSelectionState>(
      'stop checking get teams',
      build: buildCubit,
      act: (cubit) => cubit.stopCheckingGetTeams(),
      setUp: () {
        when(stopCheckingGetTeamsUseCase).thenAnswer((_) async => {});
      },
      expect: () => [],
      verify: (cubit) {
        verify(stopCheckingGetTeamsUseCase).called(2);
      },
    );

    group('init', () {
      blocTest<TeamSelectionCubit, TeamSelectionState>(
        'success & with teams',
        build: buildCubit,
        act: (cubit) => cubit.init(),
        setUp: () {
          when(startCheckingGetTeamsUseCase).thenAnswer((_) async => {});
          when(getTeamsUseCase).thenAnswer((_) async => [team]);
        },
        expect: () => [
          TeamSelectionState.idle(teams: [team])
        ],
        verify: (cubit) {
          verify(startCheckingGetTeamsUseCase).called(1);
          verify(getTeamsUseCase).called(1);
        },
      );

      blocTest<TeamSelectionCubit, TeamSelectionState>(
        'success & no teams',
        build: buildCubit,
        act: (cubit) => cubit.init(),
        setUp: () {
          when(startCheckingGetTeamsUseCase).thenAnswer((_) async => {});
          when(getTeamsUseCase).thenAnswer((_) async => <Team>[]);
        },
        expect: () => [const TeamSelectionState.noTeams()],
        verify: (cubit) {
          verify(startCheckingGetTeamsUseCase).called(1);
          verify(getTeamsUseCase).called(1);
        },
      );

      blocTest<TeamSelectionCubit, TeamSelectionState>(
        'error',
        build: buildCubit,
        act: (cubit) => cubit.init(),
        setUp: () {
          when(startCheckingGetTeamsUseCase).thenAnswer((_) async => {});
          when(getTeamsUseCase).thenThrow(Exception());
        },
        expect: () => [const TeamSelectionState.error()],
        verify: (cubit) {
          verify(startCheckingGetTeamsUseCase).called(1);
          verify(getTeamsUseCase).called(1);
        },
      );
    });

    blocTest<TeamSelectionCubit, TeamSelectionState>(
      'leave team',
      build: buildCubit,
      act: (cubit) => cubit.leaveTeam(1),
      setUp: () {
        when(() => leaveTeamUseCase(1)).thenAnswer((_) async => {});
        when(fetchTeamsUseCase).thenAnswer((_) async => {});
      },
      expect: () => [],
      verify: (cubit) {
        verify(() => leaveTeamUseCase(1)).called(1);
        verify(fetchTeamsUseCase).called(1);
      },
    );

    group('delete team', () {
      blocTest<TeamSelectionCubit, TeamSelectionState>(
        'success',
        build: buildCubit,
        act: (cubit) => cubit.deleteTeam(1),
        setUp: () {
          when(() => deleteTeamUseCase(1)).thenAnswer((_) async => {});
          when(fetchTeamsUseCase).thenAnswer((_) async => {});
        },
        expect: () => [],
        verify: (cubit) {
          verify(() => deleteTeamUseCase(1)).called(1);
          verify(fetchTeamsUseCase).called(1);
        },
      );

      blocTest<TeamSelectionCubit, TeamSelectionState>(
        'error',
        build: buildCubit,
        act: (cubit) => cubit.deleteTeam(1),
        setUp: () {
          when(() => deleteTeamUseCase(1)).thenThrow(Exception());
        },
        expect: () => [const TeamSelectionState.error()],
        verify: (cubit) {
          verify(() => deleteTeamUseCase(1)).called(1);
        },
      );
    });
  });
}
