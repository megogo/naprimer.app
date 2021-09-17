extension DateTimeExt on DateTime {

  String get getTimeFromPublish{
    DateTime now = DateTime.now();
    Duration diff = now.difference(this);
    late String result;
    if (diff.inSeconds < 60) {
      result = 'just now';
    } else if (diff.inMinutes < 60) {
      result = '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      result = '${diff.inHours} hours ago';
    } else if (diff.inDays >= 1 && diff.inDays < 31) {
      result = '${diff.inDays} days ago';
    } else if (diff.inDays >= 31 && diff.inDays < 365) {
      result = '${(diff.inDays / 31).toStringAsFixed(1)} months ago';
    } else if (diff.inDays >= 365) {
      result = '${(diff.inDays / 365).toStringAsFixed(1)} years ago';
    }
    return result;
  }
}