import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../models/guest_model.dart';
import '../models/reservation_model.dart';
import '../services/auth_service.dart';

class AuthenticationProvider extends AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Delete the current user account
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

  // Get the current logged-in GuestModel
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
        reservationSnapshot.docs
            .map((doc) => ReservationModel.fromJson(doc.data()))
            .toList();

    return GuestModel(
      id: uid,
      name: firebaseUser.displayName ?? "Guest",
      mail: firebaseUser.email ?? "No Email",
      reservations: reservations,
    );
  }

  // Logout current user (including Google sign-out)
  @override
  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      debugPrint("Error Logging Out: $e");
      throw Exception("Error Logging Out: $e");
    }
  }

  // Login with email and password and return GuestModel
  @override
  Future<GuestModel?> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return null;

      final uid = user.uid;

      // Update last login timestamp in 'users' collection
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      // Fetch reservations from 'guests' collection
      final reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('guests')
              .doc(uid)
              .collection('reservations')
              .get();

      List<ReservationModel> reservations =
          reservationSnapshot.docs
              .map((doc) => ReservationModel.fromJson(doc.data()))
              .toList();

      return GuestModel(
        id: uid,
        name: user.displayName ?? "Guest",
        mail: email,
        reservations: reservations,
      );
    } catch (e) {
      debugPrint('Login failed: $e');
      return null;
    }
  }

  // Google Sign-In returning GuestModel (not UserCredential)
  @override
  @override
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(credential);

      // After successful sign-in, load the user reservations:
      final loadData = Provider.of<HotelRooms>(context,listen: false);
      await loadData.loadReservationsForUser();

      return userCredential;
    } catch (e) {
      debugPrint("Google sign-in error: $e");
      return null;
    }
  }


  // Register new user with email/password, send verification, return GuestModel
  @override
  @override
  Future<GuestModel?> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      // Check if user already exists with this email
      final methods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        // User already registered, return null or throw error
        debugPrint("User with email $email already exists.");
        return null; // Or throw Exception("User already exists");
      }

      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ///uid
      String uid = userCredential.user!.uid;

      // Save user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // ... continue your existing logic here

      // Create GuestModel and fetch reservations...

      // Send verification email
      await userCredential.user!.sendEmailVerification();

      if (userCredential.user!.emailVerified) {
        // Email already verified (rare immediately after signup)
        return GuestModel(id: uid, name: name, mail: email, reservations: []);
      } else {
        return null; // or indicate user to verify email first
      }
    } catch (e) {
      debugPrint("Registration Failed: $e");
      throw Exception("Registration Failed: $e");
    }
  }

  // Send password reset email
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
