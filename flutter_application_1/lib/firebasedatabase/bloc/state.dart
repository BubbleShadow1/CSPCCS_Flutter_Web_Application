import 'package:equatable/equatable.dart';

// Abstract Base Class for States
abstract class FirebaseState extends Equatable {
  const FirebaseState();

  @override
  List<Object> get props => [];
}

// Initial State
class FirebaseInitial extends FirebaseState {}

// Loading State
class FirebaseLoading extends FirebaseState {}

// Success State
class FirebaseSuccess extends FirebaseState {
  final String message;

  const FirebaseSuccess(this.message);

  @override
  List<Object> get props => [message];
}

// Error State
class FirebaseError extends FirebaseState {
  final String message;

  const FirebaseError(this.message);

  @override
  List<Object> get props => [message];
}

// Fetched Users State
class UsersFetchedState extends FirebaseState {
  final List<Map<String, dynamic>> users;

  const UsersFetchedState(this.users);

  @override
  List<Object> get props => [users];
}
