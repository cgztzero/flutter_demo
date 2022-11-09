class StringUtil {
  static bool isEmpty(String? str) {
    if (str != null && str.isNotEmpty && 'null' != str) {
      return false;
    }
    return true;
  }

  static String emptyReplace(String? str, {String defaultValue = 'unknown'}) {
    if (isEmpty(str)) {
      return defaultValue;
    }
    return str!;
  }
}
