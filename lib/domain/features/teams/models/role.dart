enum Role {
  amateurMember,
  amateurAdmin,
  member,
  assistant,
  admin,
  unknown,
}

extension RoleExtension on Role {
  String get value {
    switch (this) {
      case Role.amateurMember:
        return 'AmateurMember';
      case Role.amateurAdmin:
        return 'AmateurAdmin';
      case Role.member:
        return 'Member';
      case Role.assistant:
        return 'Assistant';
      case Role.admin:
        return 'Admin';
      case Role.unknown:
        return 'Unknown';
    }
  }
}

Role teamTypeFromString(String value) {
  switch (value) {
    case 'AmateurMember':
      return Role.amateurMember;
    case 'AmateurAdmin':
      return Role.amateurAdmin;
    case 'Member':
      return Role.member;
    case 'Assistant':
      return Role.assistant;
    case 'Admin':
      return Role.admin;
    default:
      return Role.unknown;
  }
}
