import 'package:chat_flutter/core/errors/exceptions.dart';
import 'package:chat_flutter/core/models/auth_form_data.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/core/themes/app_snacks.dart';
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
                onSubmit: (formData) => _handleSubmit(formData, context),
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

  Future<void> _handleSubmit(
      AuthFormData formData, BuildContext context) async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true);

      if (formData.isLogin) {
        await AuthService().login(
          formData.email,
          formData.password,
        );
        return;
      } else {
        await AuthService().signup(formData);
      }
    } on ChatException catch (e) {
      if (!mounted) return;
      failSnackBar(e.message!, context);
    } finally {
      setState(() => isLoading = false);
    }
  }
}
