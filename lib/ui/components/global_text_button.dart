import 'package:flutter/material.dart';

import '../../app/style/app_button_style.dart';

class GlobalTextButton extends StatelessWidget {
  final String caption;
  final void Function()? onPressed;

  const GlobalTextButton({
    Key? key,
    required this.caption,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: AppButtonStyle.buttonLink,
      child: Text(caption),
    );
  }
}
