// auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/Authentication/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final user = authRepository.currentUser;
    if (user != null) {
      emit(Authenticated(user.uid));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.login(event.email, event.password);
    result.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (user) => emit(Authenticated(user!.uid)),
    );
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(Unauthenticated());
  }
}
