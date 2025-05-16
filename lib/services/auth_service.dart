import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:namesa_yassin_preoject/models/guest_model.dart';

///auth services functions
abstract class AuthService {
  ///login
  Future<GuestModel?> loginWithEmailAndPassword(String email, String password,BuildContext context,);

  ///register
  Future<GuestModel?> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  ///logout
  Future<void> logOut();

  ///get current user
  Future<GuestModel?> getCurrentUser();

  ///send reset email
  Future<String> sendResetEmail(String email);

  ///google sign in
  Future<UserCredential?> signInWithGoogle();

  ///delete account
  Future<void> deleteAccount();
}
