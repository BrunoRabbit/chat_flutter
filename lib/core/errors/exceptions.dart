class ChatException implements Exception {
  const ChatException({required this.message, this.errorCode});

  final String? message;
  final int? errorCode;
}

class ConnectionException extends ChatException {
  const ConnectionException()
      : super(message: "Servidor não conectado", errorCode: 500);
}

class InvalidEmail extends ChatException {
  const InvalidEmail()
      : super(message: "O email já está em uso", errorCode: 400);
}

class InvalidToken extends ChatException {
  const InvalidToken() : super(message: "Token inválido", errorCode: 401);
}