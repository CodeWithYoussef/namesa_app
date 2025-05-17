import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'event_model.dart';
import 'hotel_room_model.dart';
import 'resturant_model.dart';

class HotelRooms extends ChangeNotifier {
  // ------------------ Sample Data ------------------ //
  final _allRooms = <HotelRoom>[
    HotelRoom(
      id: "room_royal_suite",
      name: "Royal suite",
      price: 6000,
      imagePath: "assets/rooms/Royal suite.jpg",
      rating: 4.9,
      reviews: 60,
      numOfBeds: 2,
      gym: true,
      wifi: true,
      extraPrice: 500,
    ),
    HotelRoom(
      id: "room_suite",
      name: "Suite",
      price: 625,
      imagePath: "assets/rooms/suite.jpg",
      rating: 4.7,
      reviews: 130,
      numOfBeds: 2,
      wifi: true,
      gym: true,
      extraPrice: 150,
    ),
    HotelRoom(
      id: "room_king",
      name: "King",
      price: 460,
      imagePath: "assets/rooms/king.jpg",
      rating: 4.8,
      reviews: 260,
      numOfBeds: 2,
      gym: true,
      wifi: true,
      extraPrice: 100,
    ),
    HotelRoom(
      id: "room_double",
      name: "Double",
      price: 406,
      imagePath: "assets/rooms/double.jpg",
      rating: 4.3,
      reviews: 653,
      numOfBeds: 2,
      wifi: true,
      gym: false,
      extraPrice: 0,
    ),
    HotelRoom(
      id: "room_single",
      name: "Single",
      price: 350,
      imagePath: "assets/rooms/single.jpg",
      rating: 4.2,
      reviews: 1164,
      numOfBeds: 1,
      gym: false,
      wifi: false,
      extraPrice: 0,
    ),
  ];

  final _allRestaurants = <ResturantModel>[
    ResturantModel(
      name: "Golden Palace",
      imagePath: "assets/RESTURANTS/Golden Palac.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.5,
      reviews: 320,
      description: "The Main Hotel restaurant.",
    ),
    ResturantModel(
      name: "Atlas Palace",
      imagePath: "assets/RESTURANTS/Atlas Palace.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.7,
      reviews: 360,
      description: "Western Restaurant Cuisine.",
    ),
    ResturantModel(
      name: "Flame Of Royal",
      imagePath: "assets/RESTURANTS/Flame Of Royale.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.8,
      reviews: 480,
      description: "Grill And Steak House.",
    ),
    ResturantModel(
      name: "Rehab Palace",
      imagePath: "assets/RESTURANTS/Rehab Horizon.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.9,
      reviews: 930,
      description: "Roof Cafe.",
    ),
    ResturantModel(
      name: "The Impier Dragon",
      imagePath: "assets/RESTURANTS/The Impier Dragon.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.4,
      reviews: 1060,
      description: "Asian Cuisine.",
    ),
  ];

  final List<EventModel> _allEvents = [
    EventModel(
      name: "Amr Diab",
      imagePath: "assets/events/amr diab.jpg",
      price1: 3000,
      price2: 1500,
    ),
    EventModel(
      name: "Hamaki",
      imagePath: "assets/events/hamaki.jpg",
      price1: 2500,
      price2: 1500,
    ),
    EventModel(
      name: "Tamer Hosny",
      imagePath: "assets/events/tamer hosny.jpeg",
      price1: 3000,
      price2: 2500,
    ),
    EventModel(
      name: "Travis Scott",
      imagePath: "assets/events/travis clot.jpg",
      price1: 5000,
      price2: 3500,
    ),
    EventModel(
      name: "Elissa",
      imagePath: "assets/events/elisa.webp",
      price1: 2500,
      price2: 1500,
    ),
  ];

  final List<String> _menu = [
    "assets/menus/Rehab Horizon menu 1.jpg",
    "assets/menus/Rehab Horizon menu 2.jpg",
    "assets/menus/Rehab Horizon menu 3.jpg",
    "assets/menus/imperial dragon 1.jpg",
    "assets/menus/imperial dragon 2.jpg",
    "assets/menus/imperial dragon 3.jpg",
    "assets/menus/imperial dragon 4.jpg",
    "assets/menus/flame royal 1.jpg",
    "assets/menus/flame royal 2.jpg",
    "assets/menus/flame royal 3.jpg",
  ];

  List<HotelRoom> _filteredRooms = [];
  List<ResturantModel> _filteredRestaurants = [];
  List<EventModel> _filteredEvents = [];

  List<HotelRoom> get allRooms =>
      _filteredRooms.isEmpty ? _allRooms : _filteredRooms;

  List<ResturantModel> get allResturant =>
      _filteredRestaurants.isEmpty ? _allRestaurants : _filteredRestaurants;

  List<EventModel> get allEvents =>
      _filteredEvents.isEmpty ? _allEvents : _filteredEvents;

  // ------------------ Reservation Lists ------------------ //
  final List<HotelRoom> _reservedRooms = [];
  final List<ResturantModel> _reservedRestaurants = [];
  final List<EventModel> _reservedEvents = [];

  List<HotelRoom> get reservedRooms => List.unmodifiable(_reservedRooms);

  List<ResturantModel> get reservedRestaurants =>
      List.unmodifiable(_reservedRestaurants);

  List<EventModel> get reservedEvents => List.unmodifiable(_reservedEvents);

  // ------------------ Reservation Functions ------------------ //
  void reserveRoom(HotelRoom room) async {
    if (!_reservedRooms.contains(room)) {
      _reservedRooms.add(room);
      notifyListeners();

      await saveToReservations('room', {
        'roomId': room.id,
        'name': room.name,
        'price': room.price,
        'imagePath': room.imagePath,
      });
    }
  }

  void reserveRestaurant(ResturantModel restaurant) async {
    if (!_reservedRestaurants.contains(restaurant)) {
      _reservedRestaurants.add(restaurant);
      notifyListeners();

      await saveToReservations('restaurant', {
        'name': restaurant.name,
        'description': restaurant.description,
        'imagePath': restaurant.imagePath,
      });
    }
  }

  void reserveEvent(EventModel event) async {
    if (!_reservedEvents.contains(event)) {
      _reservedEvents.add(event);
      notifyListeners();

      await saveToReservations('event', {
        'name': event.name,
        'imagePath': event.imagePath,
        'price1': event.price1,
        'price2': event.price2,
      });
    }
  }

  // ------------------ Cancel Reservation ------------------ //
  void cancelRoomReservation(HotelRoom room) {
    if (_reservedRooms.remove(room)) notifyListeners();
  }

  void cancelRestaurantReservation(ResturantModel restaurant) {
    if (_reservedRestaurants.remove(restaurant)) notifyListeners();
  }

  void cancelEventReservation(EventModel event) {
    if (_reservedEvents.remove(event)) notifyListeners();
  }

  bool isRoomReserved(HotelRoom room) => _reservedRooms.contains(room);

  bool isRestaurantReserved(ResturantModel restaurant) =>
      _reservedRestaurants.contains(restaurant);

  bool isEventReserved(EventModel event) => _reservedEvents.contains(event);

  // ------------------ Save to Firestore ------------------ //
  Future<void> saveToReservations(
    String category,
    Map<String, dynamic> data,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('reservations').add({
      'userId': user.uid,
      'category': category,
      ...data,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // ------------------ Favorites ------------------ //
  final List<HotelRoom> _favouriteRooms = [];

  List<HotelRoom> get favouriteRooms => List.unmodifiable(_favouriteRooms);

  void addToFavouriteRooms(HotelRoom room) {
    if (!_favouriteRooms.contains(room)) {
      _favouriteRooms.add(room);
      notifyListeners();
    }
  }

  void removeFromFavouriteRooms(HotelRoom room) {
    if (_favouriteRooms.remove(room)) notifyListeners();
  }

  bool isFavouriteRoom(HotelRoom room) => _favouriteRooms.contains(room);

  final List<ResturantModel> _favouriteRestaurants = [];

  List<ResturantModel> get favouriteRestaurants =>
      List.unmodifiable(_favouriteRestaurants);

  void addToFavouriteRestaurants(ResturantModel restaurant) {
    if (!_favouriteRestaurants.contains(restaurant)) {
      _favouriteRestaurants.add(restaurant);
      notifyListeners();
    }
  }

  void removeFromFavouriteRestaurants(ResturantModel restaurant) {
    if (_favouriteRestaurants.remove(restaurant)) notifyListeners();
  }

  bool isFavouriteRestaurant(ResturantModel restaurant) =>
      _favouriteRestaurants.contains(restaurant);

  final List<EventModel> _favouriteEvents = [];

  List<EventModel> get favouriteEvents => List.unmodifiable(_favouriteEvents);

  void addToFavouriteEvents(EventModel event) {
    if (!_favouriteEvents.contains(event)) {
      _favouriteEvents.add(event);
      notifyListeners();
    }
  }

  void removeFromFavouriteEvents(EventModel event) {
    if (_favouriteEvents.remove(event)) notifyListeners();
  }

  bool isFavouriteEvent(EventModel event) => _favouriteEvents.contains(event);

  // ------------------ Search ------------------ //
  void search(String query) {
    if (query.isEmpty) {
      _filteredRooms = [];
      _filteredRestaurants = [];
      _filteredEvents = [];
    } else {
      final lower = query.toLowerCase();
      _filteredRooms =
          _allRooms.where((r) => r.name.toLowerCase().contains(lower)).toList();
      _filteredRestaurants =
          _allRestaurants
              .where((r) => r.name?.toLowerCase().contains(lower) ?? false)
              .toList();
      _filteredEvents =
          _allEvents
              .where((e) => e.name?.toLowerCase().contains(lower) ?? false)
              .toList();
    }
    notifyListeners();
  }

  // ------------------ Users Collection -------------------- //
  Future<void> saveUserToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final userData = {
      'name': user.displayName ?? '',
      'email': user.email ?? '',
      'photoUrl': user.photoURL ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    };

    // Use set with merge:true so you don't overwrite existing data unintentionally
    await userDoc.set(userData, SetOptions(merge: true));
  }

  // ------------------ Load User Data ------------------------ //

  Future<void> loadReservationsForUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;

    // Clear local reservations first
    _reservedRooms.clear();
    _reservedRestaurants.clear();
    _reservedEvents.clear();

    // Get all reservations of this user
    final snapshot =
        await FirebaseFirestore.instance
            .collection('reservations')
            .where('userId', isEqualTo: uid)
            .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final category = data['category'] as String?;

      if (category == 'room') {
        final roomId = data['roomId'] as String?;
        if (roomId != null) {
          final room = _allRooms.firstWhereOrNull((r) => r.id == roomId);
          if (room != null && !_reservedRooms.contains(room)) {
            _reservedRooms.add(room);
          }
        }
      } else if (category == 'restaurant') {
        final name = data['name'] as String?;
        if (name != null) {
          final restaurant = _allRestaurants.firstWhereOrNull(
            (r) => r.name == name,
          );
          if (restaurant != null &&
              !_reservedRestaurants.contains(restaurant)) {
            _reservedRestaurants.add(restaurant);
          }
        }
      } else if (category == 'event') {
        final name = data['name'] as String?;
        if (name != null) {
          final event = _allEvents.firstWhereOrNull((e) => e.name == name);
          if (event != null && !_reservedEvents.contains(event)) {
            _reservedEvents.add(event);
          }
        }
      }
    }

    notifyListeners();
  }

  // ------------------ Clear All Reservations ------------------ //
  void clearReservations() {
    _reservedRooms.clear();
    _reservedRestaurants.clear();
    _reservedEvents.clear();
    notifyListeners();
  }
}
