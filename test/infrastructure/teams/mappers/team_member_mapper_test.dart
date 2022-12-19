import 'package:flutter_test/flutter_test.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';
import 'package:sportly/infrastructure/teams/dtos/team_member_dto.dart';
import 'package:sportly/infrastructure/teams/mappers/team_member_mapper.dart';

void main() {
  group('TeamMemberMapper', () {
    late TeamMemberMapper mapper;

    setUp(() {
      mapper = TeamMemberMapper();
    });

    test('pro player', () {
      final dto = TeamMemberDto(
        id: 0,
        firstName: 'name',
        role: 'ProPlayer',
        lastName: 'test',
      );

      final result = mapper.fromDto(dto);
      const expected = TeamMember(
        id: 0,
        firstName: 'name',
        role: Role.proPlayer,
        lastName: 'test',
      );

      expect(result, isA<TeamMember>());
      expect(result.id, expected.id);
      expect(result.firstName, expected.firstName);
      expect(result.lastName, expected.lastName);
      expect(result.lastName, expected.lastName);
    });

    test('amateur admin', () {
      final dto = TeamMemberDto(
        id: 0,
        firstName: 'test',
        role: 'Admin',
        lastName: 'test',
      );

      final result = mapper.fromDto(dto);
      const expected = TeamMember(
        id: 0,
        firstName: 'test',
        role: Role.admin,
        lastName: 'test',
      );

      expect(result, isA<TeamMember>());
      expect(result.id, expected.id);
      expect(result.firstName, expected.firstName);
      expect(result.lastName, expected.lastName);
      expect(result.lastName, expected.lastName);
    });
  });
}
