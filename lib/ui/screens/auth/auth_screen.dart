// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:the_movie/services/providers/provider.dart';

import 'package:the_movie/app/style/app_text_style.dart';
import 'package:the_movie/ui/screens/auth/widgets/super_script.dart';

import '../../components/global_input.dart';
import '../../components/global_text_button.dart';
import 'models/auth_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to your account ')),
      body: ListView(children: const [
        _HeaderWidget(),
      ]),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          const _FormWidget(),
          const SizedBox(height: 25),
          _buildText(
              'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.'),
          const SizedBox(height: 5),
          GlobalTextButton(caption: 'Register', onPressed: () {}),
          const SizedBox(height: 25),
          _buildText(
              'If you signed up but didn\'t get your verification email, click here to have it resent.'),
          const SizedBox(height: 5),
          GlobalTextButton(caption: 'Verify email', onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildText(String text) => Text(
        text,
        style: AppTextStyle.description,
      );
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        const SuperScript(text: 'Username'),
        const SizedBox(height: 4),
        GlobalInput(
          controller: model.loginTextController,
          obscure: false,
        ),
        const SizedBox(height: 20),
        const SuperScript(text: 'Password'),
        const SizedBox(height: 4),
        GlobalInput(
          controller: model.passwordTextController,
          obscure: true,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const _LoginButtonWidget(),
            const SizedBox(width: 24),
            GlobalTextButton(caption: 'Reset password', onPressed: () {}),
          ],
        )
      ],
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    final onPressed = model!.canStartAuth ? () => model.auth(context) : null;
    final child = model.authInProgress == true
        ? const SizedBox(
            height: 20,
            width: 20,
            child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        : const Text('Login');

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: const Color(0xFF2196F3)),
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        errorMessage,
        style: AppTextStyle.errorText,
      ),
    );
  }
}
