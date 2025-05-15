import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namesa_yassin_preoject/models/guest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/reservation_model.dart';
import '../services/auth_service.dart';

class AuthenticationProvider extends AuthService {
  ///access the firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // % ------------------------------------------------------------------------- % //

  ///delete the account ✅
  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception("No User Logged In");
      }

      await user.delete();
      await logOut();
    } catch (e) {
      debugPrint("Error Deleting The Account: $e");
      throw Exception("Error Deleting The Account: $e");
    }
  }

  // % ------------------------------------------------------------------------- % //

  ///get Current User ✅

  @override
  Future<GuestModel?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) throw Exception("No User Logged In");

    final uid = firebaseUser.uid;

    final reservationSnapshot =
        await FirebaseFirestore.instance
            .collection('guests')
            .doc(uid)
            .collection('reservations')
            .get();

    List<ReservationModel> reservations =
        reservationSnapshot.docs.map((doc) {
          return ReservationModel.fromJson(doc.data());
        }).toList();

    return GuestModel(
      id: uid,
      name: firebaseUser.displayName ?? "Guest", // Ensure fallback value
      mail: firebaseUser.email ?? "No Email",
      reservations: reservations,
    );
  }

  // % ------------------------------------------------------------------------- % //

  ///logOut ✅
  @override
  Future<void> logOut() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint("Error Logging Out: $e");
      throw Exception("Error Logging Out: $e");
    }
  }

  // % ------------------------------------------------------------------------- % //

  ///login With Email And Password ✅
  @override
  Future<GuestModel?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      final reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('guests')
              .doc(uid)
              .collection('reservations')
              .get();

      List<ReservationModel> reservations =
          reservationSnapshot.docs.map((doc) {
            return ReservationModel.fromJson(doc.data());
          }).toList();

      return GuestModel(
        id: uid,
        name: userCredential.user!.displayName ?? "Guest",
        // Use displayName directly
        mail: email,
        reservations: reservations,
      );
    } catch (e) {
      debugPrint('Login failed: $e');
      return null;
    }
  }

  // % ------------------------------------------------------------------------- % //

  ///google sign in ✅
  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Force sign out first to ensure account picker is shown
      await GoogleSignIn().signOut();

      // Trigger the authentication flow and show the account picker
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Abort if the user canceled the sign-in
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential and return the result
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Google sign-in error: $e");
      return null;
    }
  }

  ///register With Email And Password ✅
  @override
  Future<GuestModel?> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ///uid
      String uid = userCredential.user!.uid;

      // ✅ Save user data in 'users' collection
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create GuestModel
      GuestModel guest = GuestModel(
        id: uid,
        name: name,
        mail: email,
        reservations: [],
      );

      // Fetch reservations from Firestore
      QuerySnapshot reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('guests')
              .doc(uid)
              .collection('reservations')
              .get();

      List<ReservationModel> reservations =
          reservationSnapshot.docs.map((doc) {
            return ReservationModel.fromJson(
              doc.data() as Map<String, dynamic>,
            );
          }).toList();

      GuestModel guestModel = GuestModel(
        id: uid,
        name: name,
        mail: email,
        reservations: reservations,
      );

      // Send verification email
      await userCredential.user!.sendEmailVerification();

      // Check if the email is verified
      if (userCredential.user!.emailVerified) {
        return guestModel;
      } else {
        // Return null or a custom error message
        return null; // or "Please verify your email first."
      }
    } catch (e) {
      debugPrint("Registration Failed: $e");
      throw Exception("Registration Failed: $e");
    }
  }

  // % ------------------------------------------------------------------------- % //

  ///send Reset Email ✅
  @override
  Future<String> sendResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password Reset Email Has Been Sent For $email";
    } catch (e) {
      debugPrint("Error Sending Reset Email: $e");
      return "An Error Occurred: $e";
    }
  }
}
