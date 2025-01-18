import 'package:equatable/equatable.dart';

// Abstract Base Class for Events
abstract class FirebaseEvent extends Equatable {
  const FirebaseEvent();

  @override
  List<Object> get props => [];
}

// Event to Add a User
class AddUserEvent extends FirebaseEvent {
  final String username;

  const AddUserEvent(this.username);

  @override
  List<Object> get props => [username];
}

// Event to Add Data
class AddDataEvent extends FirebaseEvent {
  final Map<String, dynamic> data;

  const AddDataEvent(this.data);

  @override
  List<Object> get props => [data];
}

// Event to Fetch Users
class FetchUsersEvent extends FirebaseEvent {}
