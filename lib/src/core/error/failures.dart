import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  // If the subclass have some properties, they'll get passed to the ..
  // so that Equatable can perform value comparison
  Failure([List properties = const <dynamic>[]]): super();
}


// General failures
class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}