import 'dart:io';

import 'package:chat_flutter/core/models/auth_form_data.dart';
import 'package:chat_flutter/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({required this.onSubmit, super.key});

  final void Function(AuthFormData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup) ...[
                UserImagePicker(
                  onImagePick: (image) => _handleImagePick(image),
                ),
                TextFormField(
                  initialValue: _formData.name,
                  onChanged: (text) => _formData.name = text,
                  key: const ValueKey("name"),
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (text) {
                    final name = text ?? '';
                    if (name.length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres';
                    }

                    return null;
                  },
                ),
              ],
              TextFormField(
                key: const ValueKey("email"),
                initialValue: _formData.email,
                onChanged: (text) => _formData.email = text,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (text) {
                  final email = text ?? '';
                  if (!email.contains('@')) {
                    return 'Nome deve ter no mínimo 5 caracteres';
                  }

                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("password"),
                initialValue: _formData.password,
                onChanged: (text) => _formData.password = text,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (text) {
                  final password = text ?? '';
                  if (password.length < 6) {
                    return 'Senha deve ter no mínimo 5 caracteres';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _submit(),
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                child: Text(_formData.isLogin
                    ? 'Criar nova conta?'
                    : 'Já possui conta?'),
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _submit() {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem nao selecionada!');
    }
    
    widget.onSubmit(_formData);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
