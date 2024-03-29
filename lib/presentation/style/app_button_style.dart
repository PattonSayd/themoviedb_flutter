import 'package:flutter/material.dart';
import 'package:the_movie/presentation/style/app_text_style.dart';
import 'package:the_movie/presentation/theme/app_colors.dart';

abstract class AppButtonStyle {
  static final ButtonStyle buttonLink = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColors.buttonLink),
      textStyle: MaterialStateProperty.all(AppTextStyle.button));

  static final ButtonStyle button = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(AppColors.button),
    textStyle: MaterialStateProperty.all(AppTextStyle.button),
  );
}
