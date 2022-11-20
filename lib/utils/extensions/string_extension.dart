extension NullableStringExtension on String? {
  bool get nullOrEmpty {
    if (this == null) {
      return true;
    }
    if (this!.isEmpty) {
      return true;
    }
    return false;
  }
}
