extension IntExtension on int {
  String get estimate {
    if (this <= 10) return '$this';
    var data = this - (this % 10);
    if (data == this) data = this - 5;
    return 'over $data';
  }
}
