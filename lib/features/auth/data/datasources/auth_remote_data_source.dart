import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_firebase_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(String email, String password, String name);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._auth, this._firestore);

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(String email, String password, String name) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'name': name,
    });
    
    return UserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}