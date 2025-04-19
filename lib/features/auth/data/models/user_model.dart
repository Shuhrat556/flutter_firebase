import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String? name;

  UserModel({required this.uid, required this.email, this.name});

  factory UserModel.fromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email!, name: user.displayName);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}