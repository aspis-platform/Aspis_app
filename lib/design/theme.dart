import 'dart:ui';

abstract class Palette {
  static Color get main4 => Color(0xFF235328);
  static Color get main3 => Color(0xFF798645);
  static Color get main2 => Color(0xFF89B66B);
  static Color get main1 => Color(0xFFDCF1CE);

  static Color get sub4 => Color(0xFF3674B5);
  static Color get sub3 => Color(0xFFA1E3F9);
  static Color get sub2 => Color(0xFF578FCA);
  static Color get sub1 => Color(0xFFD1F8EF);

  static Color get red => Color(0xFFF33434);
  static Color get link => Color(0xFF4463FF);
}

extension Weight on FontWeight {
  static const FontWeight regular = FontWeight.w500;
  static const FontWeight medium = FontWeight.w600;
  static const FontWeight semiBold = FontWeight.w700;
  static const FontWeight bold = FontWeight.w800;
}