import 'package:flutter/material.dart';
import 'package:the_movie/ui/style/app_text_style.dart';

class SuperScript extends StatelessWidget {
  final String text;

  const SuperScript({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyle.superScript);
  }
}
