import 'package:chat_flutter/core/models/auth_form_data.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service_impl.dart';

abstract class AuthService {
  ChatUser? get currentUser;
  Stream<ChatUser?> get userChanges;

  Future<void> signup(AuthFormData formData);

  Future<void> login(String email, String password);

  Future<void> logout();

  factory AuthService() {
    return AuthServiceImpl();
  }
}
