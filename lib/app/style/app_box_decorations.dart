import 'package:flutter/material.dart';
import 'package:the_movie/ui/theme/app_colors.dart';

class AppDecorations {
  const AppDecorations._();

  static const InputDecoration input = InputDecoration(
    isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.inputFocused, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.inputEnable, width: 1),
    ),
  );
}
