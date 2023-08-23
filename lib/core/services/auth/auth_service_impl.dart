import 'dart:async';
import 'dart:convert';

import 'package:chat_flutter/core/errors/exception_handler.dart';
import 'package:chat_flutter/core/errors/exceptions.dart';
import 'package:chat_flutter/core/models/auth_form_data.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_request_service.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/core/services/local_storage/local_storage_service.dart';

class AuthServiceImpl implements AuthService {
  static final HttpService httpService = AuthRequestService();
  static final LocalStorageService localStorage = LocalStorageServiceImpl();

  static const String url = "http://192.168.15.9:3000/api/user";
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static const String tokenAccessKey = 'token';

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    String? token = await localStorage.read<String>(tokenAccessKey);

    _currentUser = null;

    if (token != null) {
      await _buildUserData(token);
    }

    _controller = controller;
    _controller?.add(_currentUser);
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    final authUrl = Uri.parse('$url/login');

    try {
      final response = await httpService.post(
        url: authUrl,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        _handleUserAccess(response);
        return;
      }

      throw exceptionHandler(response.statusCode);
    } on ChatException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    final tokenUrl = Uri.parse('$url/logout');

    await localStorage.deleteKey(tokenAccessKey);
    try {
      final response = await httpService.post(
        url: tokenUrl,
        body: jsonEncode({"id": _currentUser?.id}),
      );

      if (response.statusCode == 200) {
        _currentUser = null;
        _controller?.add(_currentUser);
      }
    } on ChatException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signup(AuthFormData formData) async {
    final authUrl = Uri.parse(url);

    try {
      final response = await httpService.post(
        url: authUrl,
        body: jsonEncode({
          "name": formData.name,
          "email": formData.email,
          "password": formData.password,
          "photo": formData.image?.path ?? 'assets/images/avatar.png',
        }),
      );
      if (response.statusCode == 201) {
        formData.toggleAuthMode();
        return;
      }

      throw exceptionHandler(response.statusCode);
    } on ChatException catch (_) {
      rethrow;
    }
  }

  static Future<void> _buildUserData(String token) async {
    Map<String, dynamic>? userData = await _verifyToken(token);

    if (userData != null) {
      final currentUser = ChatUser(
        id: userData['id'].toString(),
        name: userData['name'],
        email: userData['email'],
        imageUrl: userData['photo'],
      );

      _currentUser = currentUser;
    }
  }

  static Future<Map<String, dynamic>?> _verifyToken(String token) async {
    final tokenUrl = Uri.parse('$url/verify-token');

    final response = await httpService.post(
      url: tokenUrl,
      body: jsonEncode({"token": token}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['user'];
    }

    return null;
  }

  Future<void> _handleUserAccess(response) async {
    final responseData = json.decode(response.body);

    final userData = responseData['user'];

    _currentUser = ChatUser(
      id: userData['id'].toString(),
      name: userData['name'],
      email: userData['email'],
      imageUrl: userData['photo'],
    );

    _controller?.add(_currentUser);

    final String? token = responseData['token'];
    await localStorage.save<String>(tokenAccessKey, token ?? "");
  }
}
