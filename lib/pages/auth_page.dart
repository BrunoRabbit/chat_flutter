// ignore_for_file: control_flow_in_finally

import 'package:chat_flutter/core/models/auth_form_data.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: (formData) => _handleSubmit(formData),
              ),
            ),
          ),
          if (isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, .5)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true);

      if (formData.isLogin) {
        await AuthService().login(
          formData.email,
          formData.password,
        );
      } else {
        await AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
          formData,
        );
      }
    } catch (e) {
    } finally {
      //   print(isLoading);
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }
}
