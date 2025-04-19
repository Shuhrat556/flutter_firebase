import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_firebase_app/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailAndPassword {
  final AuthRepository repository;

  SignInWithEmailAndPassword(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }
}