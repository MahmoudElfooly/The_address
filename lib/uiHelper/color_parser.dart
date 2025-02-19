import 'dart:ui';

Color parseColor(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor'; // Add opacity if missing
  }
  return Color(int.parse(hexColor, radix: 16));
}
