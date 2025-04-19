import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_firebase_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:test_firebase_app/features/auth/data/models/user_model.dart';
import 'package:test_firebase_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmailAndPassword(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message ?? 'Authentication Failed'));
    }
  }

  // Similar implementations for other methods
}