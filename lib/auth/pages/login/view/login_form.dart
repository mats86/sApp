import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator_app/auth/view/auth_form_shell.dart';

import '../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: AuthFormShell(
        title: 'LOGIN',
        child:
        Column(children: [_LoginEmailInput(controller: _emailController)]),
      ),
    );
  }
}

class _LoginEmailInput extends StatelessWidget {
  final TextEditingController controller;

  const _LoginEmailInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'^[ctrl]+\s*v$')),
              // Disable all input
            ],
            contextMenuBuilder: null,
            // onChanged: (email) => context
            //     .read<LoginBloc>()
            //     .add(ParentEmailChanged(email)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Deine BESTE E-Mail',
                      style: TextStyle(fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                  ],
                ),
              ),
              errorText: state.email.displayError != null
                  ? state.email.error?.message
                  : null,
            ),
          );
        });
  }
}
