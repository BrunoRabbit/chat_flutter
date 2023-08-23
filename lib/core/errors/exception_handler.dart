import 'package:chat_flutter/core/errors/exceptions.dart';

const _exceptions = [
  ConnectionException(),
  InvalidEmail(),
  InvalidToken(),
  InternalError(),
  DataUpdateNotReceive(),
  UserLoginFailed(),
];

ChatException exceptionHandler(int code) {
  for (final exception in _exceptions) {
    if (exception.errorCode == code) return exception;
  }

  throw const ChatException(message: "Erro desconhecido!", errorCode: 501);
}
