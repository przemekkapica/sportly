enum TeamType {
  professional,
  amateur,
  unknown,
}

extension TeamTypeExtension on TeamType {
  String get value {
    switch (this) {
      case TeamType.professional:
        return 'Professional';
      case TeamType.amateur:
        return 'Amateur';
      case TeamType.unknown:
        return 'Unknown';
    }
  }
}

TeamType teamTypeFromString(String value) {
  switch (value) {
    case 'Professional':
      return TeamType.professional;
    case 'Amateur':
      return TeamType.amateur;
    default:
      return TeamType.unknown;
  }
}
