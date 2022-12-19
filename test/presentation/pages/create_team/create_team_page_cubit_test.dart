import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/domain/use_cases/create_team_use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportly/domain/use_cases/fetch_teams_use_case.dart';
import 'package:sportly/domain/use_cases/get_disciplines_use_case.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page_cubit.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page_state.f.dart';

class MockCreateTeamUseCase extends Mock implements CreateTeamUseCase {}

class MockGetDisciplinesUseCase extends Mock implements GetDisciplinesUseCase {}

class MockFetchTeamsUseCase extends Mock implements FetchTeamsUseCase {}

void main() {
  group('CreateTeamPageCubit', () {
    late MockCreateTeamUseCase createTeamUseCase;
    late MockGetDisciplinesUseCase getDisciplinesUseCase;
    late MockFetchTeamsUseCase fetchTeamsUseCase;

    late CreateTeamPageCubit cubit;

    setUp(() {
      createTeamUseCase = MockCreateTeamUseCase();
      getDisciplinesUseCase = MockGetDisciplinesUseCase();
      fetchTeamsUseCase = MockFetchTeamsUseCase();

      cubit = CreateTeamPageCubit(
        createTeamUseCase,
        getDisciplinesUseCase,
        fetchTeamsUseCase,
      );
    });

    tearDown(() {
      cubit.close();
    });

    CreateTeamPageCubit buildCubit() {
      return CreateTeamPageCubit(
        createTeamUseCase,
        getDisciplinesUseCase,
        fetchTeamsUseCase,
      );
    }

    test('initial state is loading', () {
      expect(cubit.state, const CreateTeamPageState.loading());
    });

    group('init', () {
      blocTest<CreateTeamPageCubit, CreateTeamPageState>(
        'success',
        build: buildCubit,
        setUp: () {
          when(getDisciplinesUseCase).thenAnswer(
            (_) async => <SportDiscipline>[],
          );
        },
        act: (cubit) => cubit.init(),
        expect: () => [
          const CreateTeamPageState.idle(
            disciplines: [],
            submitButtonEnabled: false,
          )
        ],
        verify: (cubit) {
          verify(getDisciplinesUseCase).called(1);
        },
      );

      blocTest<CreateTeamPageCubit, CreateTeamPageState>(
        'error',
        build: buildCubit,
        setUp: () {
          when(getDisciplinesUseCase).thenThrow(Exception());
        },
        act: (cubit) => cubit.init(),
        expect: () => [const CreateTeamPageState.error()],
        verify: (cubit) {
          verify(getDisciplinesUseCase).called(1);
        },
      );
    });

    group('submit', () {
      blocTest<CreateTeamPageCubit, CreateTeamPageState>(
        'success',
        build: buildCubit,
        setUp: () {
          when(getDisciplinesUseCase).thenAnswer(
            (_) async => <SportDiscipline>[],
          );
          when(
            () => createTeamUseCase(
              const CreateTeam(
                discipline: SportDiscipline(name: 'Football'),
                location: null,
                name: 'team',
                organizationName: null,
                teamType: TeamType.professional,
              ),
            ),
          ).thenAnswer(
            (_) async {},
          );
          when(fetchTeamsUseCase).thenAnswer(
            (_) async {},
          );
        },
        act: (cubit) async {
          await cubit.init();
          cubit.onTeamNameChanged('team');
          cubit.onSportDisciplineChanged(
            const SportDiscipline(name: 'Football'),
          );
          cubit.submit();
        },
        expect: () => [
          const CreateTeamPageState.idle(
            disciplines: [],
            submitButtonEnabled: false,
          ),
          const CreateTeamPageState.idle(
            disciplines: [],
            submitButtonEnabled: true,
          )
        ],
        verify: (cubit) {
          verify(getDisciplinesUseCase).called(1);
          verify(
            () => createTeamUseCase(
              const CreateTeam(
                discipline: SportDiscipline(name: 'Football'),
                location: null,
                name: 'team',
                organizationName: null,
                teamType: TeamType.professional,
              ),
            ),
          ).called(1);
          verify(fetchTeamsUseCase).called(1);
        },
      );

      blocTest<CreateTeamPageCubit, CreateTeamPageState>(
        'error',
        build: buildCubit,
        setUp: () {
          when(getDisciplinesUseCase).thenAnswer(
            (_) async => <SportDiscipline>[],
          );
          when(
            () => createTeamUseCase(
              const CreateTeam(
                discipline: SportDiscipline(name: 'Football'),
                location: null,
                name: 'team',
                organizationName: null,
                teamType: TeamType.professional,
              ),
            ),
          ).thenThrow(Exception());
        },
        act: (cubit) async {
          await cubit.init();
          cubit.onTeamNameChanged('team');
          cubit.onSportDisciplineChanged(
            const SportDiscipline(name: 'Football'),
          );
          cubit.submit();
        },
        expect: () => [
          const CreateTeamPageState.idle(
            disciplines: [],
            submitButtonEnabled: false,
          ),
          const CreateTeamPageState.idle(
            disciplines: [],
            submitButtonEnabled: true,
          ),
          const CreateTeamPageState.error()
        ],
        verify: (cubit) {
          verify(getDisciplinesUseCase).called(1);
          verify(
            () => createTeamUseCase(
              const CreateTeam(
                discipline: SportDiscipline(name: 'Football'),
                location: null,
                name: 'team',
                organizationName: null,
                teamType: TeamType.professional,
              ),
            ),
          ).called(1);
          verifyNever(fetchTeamsUseCase);
        },
      );
    });
  });
}
