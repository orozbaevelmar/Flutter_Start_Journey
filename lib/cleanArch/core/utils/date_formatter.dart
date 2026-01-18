String formatTimeAgo(DateTime date) {
  final now = DateTime.now().toUtc();

  final difference = now.difference(date);

  if (difference.isNegative) {
    return 'in ' + _formatDuration(difference.abs());
  }

  // Less than 1 minute
  if (difference.inSeconds < 60) {
    return 'just now';
  }

  // Less than 1 hour
  else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return '$minutes minute${minutes == 1 ? '' : 's'} ago';
  }

  // Less than 24 hours
  else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return '$hours hour${hours == 1 ? '' : 's'} ago';
  }
  // Less than 7 days
  else if (difference.inDays < 7) {
    final days = difference.inDays;
    return '${days} day${days == 1 ? '' : 's'} ago';
  }
  // Less than 30 days
  else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).round();
    return '${weeks} week${weeks == 1 ? '' : 's'} ago';
  }

  // For older dates (return standard format)
  return '${date.month}/${date.day}/${date.year}';
}

// Helper function for future dates (optional)
String _formatDuration(Duration duration) {
  if (duration.inDays > 0)
    return '${duration.inDays} day${duration.inDays == 1 ? '' : 's'}';
  if (duration.inHours > 0)
    return '${duration.inHours} hour${duration.inHours == 1 ? '' : 's'}';
  return '${duration.inMinutes} minute${duration.inMinutes == 1 ? '' : 's'}';
}
