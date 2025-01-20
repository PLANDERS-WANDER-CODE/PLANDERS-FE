import 'package:flutter/material.dart';

class AppColors {
  // 메인 색상
  static const Color primary = Color(0xFF4A90E2);

  // 기본 색상
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;

  // 버튼 색상
  static const Color buttonBackground = Color(0xFF2D2D2D);
  static const Color googleButtonBackground = Colors.black87;

  // 텍스트 필드 테두리 색상
  static const Color textFieldBorder = Colors.grey;
  static const Color textFieldFocusedBorder = primary;

  // 텍스트 색상
  static const Color labelText = Colors.grey;

  // TextField 스타일
  static InputDecoration textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: labelText,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: textFieldBorder,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: textFieldFocusedBorder,
          width: 2,
        ),
      ),
    );
  }

  // DropdownButton 컨테이너 데코레이션
  static BoxDecoration dropdownDecoration = BoxDecoration(
    border: Border.all(color: grey),
    borderRadius: BorderRadius.circular(8),
  );

  // 회원가입 버튼 스타일
  static ButtonStyle signupButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: buttonBackground,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}