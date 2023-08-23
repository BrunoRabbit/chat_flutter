class ChatException implements Exception {
  const ChatException({required this.message, this.errorCode});

  final String? message;
  final int? errorCode;
}

class ConnectionException extends ChatException {
  const ConnectionException()
      : super(message: "Tempo esgotado da conexão", errorCode: 522);
}

class UserNotFound extends ChatException {
  const UserNotFound()
      : super(message: "Usuário não encontrado", errorCode: 404);
}

class InvalidEmail extends ChatException {
  const InvalidEmail()
      : super(message: "O email já está em uso", errorCode: 409);
}

class InvalidToken extends ChatException {
  const InvalidToken() : super(message: "Token inválido", errorCode: 401);
}

class InternalError extends ChatException {
  const InternalError()
      : super(message: "Erro interno do servidor", errorCode: 500);
}

class DataUpdateNotReceive extends ChatException {
  const DataUpdateNotReceive()
      : super(message: "Dados para atualizar não encontrados", errorCode: 400);
}

class UserLoginFailed extends ChatException {
  const UserLoginFailed()
      : super(message: "Email ou senha incorretos", errorCode: 406);
}
