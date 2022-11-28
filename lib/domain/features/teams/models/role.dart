enum Role {
  player,
  admin,
  proPlayer,
  assistant,
  proAdmin,
  unknown,
}

extension RoleExtension on Role {
  String get value {
    switch (this) {
      case Role.player:
        return 'Player';
      case Role.admin:
        return 'Admin';
      case Role.proPlayer:
        return 'ProPlayer';
      case Role.assistant:
        return 'Assistant';
      case Role.proAdmin:
        return 'ProAdmin';
      case Role.unknown:
        return 'Unknown';
    }
  }

  bool get isAdminOrAssistant =>
      this == Role.admin || this == Role.proAdmin || this == Role.assistant;

  bool get isAdmin => this == Role.admin || this == Role.proAdmin;

  bool get isAssistant => this == Role.assistant;
}

Role roleFromString(String value) {
  switch (value) {
    case 'Player':
      return Role.player;
    case 'Admin':
      return Role.admin;
    case 'ProPlayer':
      return Role.proPlayer;
    case 'Assistant':
      return Role.assistant;
    case 'ProAdmin':
      return Role.proAdmin;
    default:
      return Role.unknown;
  }
}
