import 'package:namesa_yassin_preoject/models/guest_model.dart';

///auth services functions
abstract class AuthService {
  ///login
  Future<GuestModel?> loginWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

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
  Future<String> sendResetEmail();

  ///delete account
  Future<void> deleteAccount();
}
