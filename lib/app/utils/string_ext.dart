enum TruncatePosition {START, MIDDLE, END }

extension StringData on String{

  String truncate(int maxLength,
      {String omission = '...',
        TruncatePosition position = TruncatePosition.END}) {
    if (this.length <= maxLength) {
      return this;
    }
    switch (position) {
      case TruncatePosition.START:
        return omission +
            this.substring(this.length - maxLength + omission.length);
      case TruncatePosition.MIDDLE:
        return _truncateMiddle(this, maxLength, omission);
      default:
        return this.substring(0, maxLength - omission.length) + omission;
    }
  }

  String _truncateMiddle(String text, int maxLength, String omission) {
    final omissionLength = omission.length;
    final delta = text.length % 2 == 0
        ? ((maxLength - omissionLength) / 2).ceil()
        : ((maxLength - omissionLength) / 2).floor();
    return text.substring(0, delta) +
        omission +
        text.substring(text.length - maxLength + omissionLength + delta);
  }
}