extension IntExt on int{
  String get roundCount{
    late String result;
    if (this < 1000) {
      result = '$this';
    } else if (this >= 1000 && this < 1000000) {
      result = '${(this / 1000).roundToDouble().toStringAsPrecision(2)}k';
    } else if (this >= 1000000) {
      result = '${(this / 1000000).roundToDouble().toStringAsPrecision(2)}m';
    }
    return result;
  }
}