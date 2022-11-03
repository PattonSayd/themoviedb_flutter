import 'package:flutter/material.dart';
import 'package:the_movie/ui/theme/app_colors.dart';

class AppTextStyle {
  const AppTextStyle._();

  static const TextStyle description = TextStyle(
    fontSize: 16,
    color: AppColors.description,
  );

  static const superScript = TextStyle(
    fontSize: 16,
    color: AppColors.superScript,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const errorText = TextStyle(
    fontSize: 17,
    color: AppColors.errorText,
  );

  static const inputText = TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );
}
