String timeDifference(DateTime date) {
  final difference = DateTime.now().difference(date);
  if (difference.inDays > 365) {
    return '${(difference.inDays / 365).floor()}y';
  } else if (difference.inDays > 30) {
    return '${(difference.inDays / 30).floor()}m';
  } else if (difference.inDays >= 7) {
    return '${(difference.inDays / 7).floor()}w ${difference.inDays % 7}d';
  } else if (difference.inDays > 0) {
    return '${difference.inDays}d';
  } else {
    return 'Today';
  }
}
