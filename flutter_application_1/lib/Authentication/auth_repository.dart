// auth_repo.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:either_dart/either.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Either<String, User?>> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential.user);
    } catch (e) {
      return Left("Login failed: ${e.toString()}");
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
