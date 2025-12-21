extension StringExtensions on String {
  bool containsIgnoreCase(String query) {
    return toLowerCase().contains(query.toLowerCase());
  }

  bool startsWithIgnoreCase(String query) {
    return toLowerCase().startsWith(query.toLowerCase());
  }

  String toCapitalise() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String formatTimeString() {
    // Remove any whitespace and convert to lowercase for consistent processing
    String cleaned = trim().toLowerCase();

    // Check if it contains am/pm
    if (cleaned.contains('am') || cleaned.contains('pm')) {
      // Split by 'am' or 'pm'
      String period = cleaned.contains('am') ? 'am' : 'pm';
      String timePart = cleaned.replaceAll(period, '').trim();

      // Return with uppercase period and proper spacing
      return '$timePart ${period.toUpperCase()}';
    }
    return this;
  }
}
