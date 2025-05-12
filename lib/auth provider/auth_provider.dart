import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:namesa_yassin_preoject/models/guest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/reservation_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends AuthService {
  ///access the firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // % ------------------------------------------------------------------------- % //

  ///delete the account
  @override
  Future<void> deleteAccount() async {}

  // % ------------------------------------------------------------------------- % //

  ///get Current User

  @override
  Future<GuestModel?> getCurrentUser() async {
    return null;
  }

  // % ------------------------------------------------------------------------- % //

  ///logOut
  @override
  Future<void> logOut() async {}

  // % ------------------------------------------------------------------------- % //

  ///login With Email And Password
  @override
  Future<GuestModel?> loginWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      // Attempt to sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      ///user id
      String uid = userCredential.user!.uid;

      // Fetch reservations from Firestore (if using subcollection)
      QuerySnapshot reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('guests')
              .doc(uid)
              .collection('reservations')
              .get();

      // % ------------------------------------------------------------------------- % //

      ///ReservationModel list
      List<ReservationModel> reservations =
          reservationSnapshot.docs.map((doc) {
            return ReservationModel.fromJson(
              doc.data() as Map<String, dynamic>,
            );
          }).toList();

      // Create and return GuestModel
      GuestModel guestModel = GuestModel(
        id: uid,
        name: name,
        mail: email,
        reservations: reservations,
      );

      return guestModel;
    } catch (e) {
      debugPrint('Login failed: $e');
      return null;
    }
  }

  // % ------------------------------------------------------------------------- % //
  ///register With Email And Password
  @override
  Future<GuestModel?> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      ///attempt to register
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      ///user id
      String uid = userCredential.user!.uid;
      GuestModel guest = GuestModel(
        id: uid,
        name: email,
        mail: email,
        reservations: [],
      );

      // Fetch reservations from Firestore (if using subcollection)
      QuerySnapshot reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('guests')
              .doc(uid)
              .collection('reservations')
              .get();

      ///ReservationModel list
      List<ReservationModel> reservations =
          reservationSnapshot.docs.map((doc) {
            return ReservationModel.fromJson(
              doc.data() as Map<String, dynamic>,
            );
          }).toList();

      ///create user
      GuestModel guestModel = GuestModel(
        id: uid,
        name: name,
        mail: email,
        reservations: reservations,
      );

      ///return user
      return guestModel;
    } catch (e) {
      throw Exception("Registration Failed: $e ");
    }
  }

  ///send Reset Email
  @override
  Future<String> sendResetEmail() async {
    return "";
  }
}
