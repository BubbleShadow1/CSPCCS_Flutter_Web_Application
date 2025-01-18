import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/event.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/state.dart';
import 'package:flutter_application_1/firebasedatabase/firebaserepo.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final FirebaseRepository _firebaseRepository;

  FirebaseBloc(this._firebaseRepository) : super(FirebaseInitial()) {
    // Register event handlers
    on<AddUserEvent>(_handleAddUserEvent);
    on<AddDataEvent>(_handleAddDataEvent);
    on<FetchUsersEvent>(_handleFetchUsersEvent);
  }

  // Handler for AddUserEvent
  Future<void> _handleAddUserEvent(
      AddUserEvent event, Emitter<FirebaseState> emit) async {
    emit(FirebaseLoading());
    try {
      await _firebaseRepository.addUser(event.username);
      emit(const FirebaseSuccess("User added successfully!"));
    } catch (e) {
      emit(FirebaseError("Error adding user: $e"));
    }
  }

  // Handler for AddDataEvent
  Future<void> _handleAddDataEvent(
      AddDataEvent event, Emitter<FirebaseState> emit) async {
    emit(FirebaseLoading());
    try {
      await _firebaseRepository.addData(event.data);
      emit(const FirebaseSuccess("Data added successfully!"));
    } catch (e) {
      emit(FirebaseError("Error adding data: $e"));
    }
  }

  // Handler for FetchUsersEvent
  Future<void> _handleFetchUsersEvent(
      FetchUsersEvent event, Emitter<FirebaseState> emit) async {
    emit(FirebaseLoading());
    try {
      final users = await _firebaseRepository.fetchUsers();
      emit(UsersFetchedState(users));
    } catch (e) {
      emit(FirebaseError("Error fetching users: $e"));
    }
  }
}
