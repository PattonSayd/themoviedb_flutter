// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:the_movie/app/style/app_box_decorations.dart';
import 'package:the_movie/app/style/app_text_style.dart';

class GlobalInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;

  const GlobalInput({Key? key, required this.controller, required this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      textInputAction: TextInputAction.next,
      // maxLength: 16,
      decoration: AppDecorations.input,
      style: AppTextStyle.inputText,
    );
  }
}
