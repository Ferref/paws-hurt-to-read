class Formatter {
  const Formatter();

  static String truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    }
    return '${text.substring(0, limit)}...';
  }
}
