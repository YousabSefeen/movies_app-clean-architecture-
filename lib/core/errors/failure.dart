import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

//TODO :ServerFailure this in remote database
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
  });
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({
    required super.message,
  });
}
