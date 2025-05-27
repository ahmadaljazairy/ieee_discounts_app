extension StringArabicExtension on String {
  bool get isArabic {
    return RegExp(r'^[\u0600-\u06FF]').hasMatch(this);
  }
}
