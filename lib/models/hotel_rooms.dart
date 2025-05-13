import 'package:flutter/cupertino.dart';
import 'hotel_room_model.dart';
import 'resturant_model.dart';

class HotelRooms extends ChangeNotifier {
  // ------------------ ROOMS ------------------
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
    ),
  ];

  List<HotelRoom> _filteredRooms = [];

  List<HotelRoom> get allRooms =>
      _filteredRooms.isEmpty ? _allRooms : _filteredRooms;

  final List<HotelRoom> _favouriteRooms = [];

  List<HotelRoom> get favouriteRooms => List.unmodifiable(_favouriteRooms);

  void addToFavouriteRooms(HotelRoom room) {
    if (!_favouriteRooms.contains(room)) {
      _favouriteRooms.add(room);
      notifyListeners();
    }
  }

  void removeFromFavouriteRooms(HotelRoom room) {
    if (_favouriteRooms.remove(room)) {
      notifyListeners();
    }
  }

  bool isFavouriteRoom(HotelRoom room) => _favouriteRooms.contains(room);

  // ------------------ RESTAURANTS ------------------

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

  List<String> get menu => _menu; // Getter for _menu

  List<ResturantModel> _filteredRestaurants = [];

  List<ResturantModel> get allResturant =>
      _filteredRestaurants.isEmpty ? _allRestaurants : _filteredRestaurants;

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
    if (_favouriteRestaurants.remove(restaurant)) {
      notifyListeners();
    }
  }

  bool isFavouriteRestaurant(ResturantModel restaurant) =>
      _favouriteRestaurants.contains(restaurant);

  // ------------------ SEARCH ------------------ //

  void search(String query) {
    if (query.isEmpty) {
      _filteredRooms = [];
      _filteredRestaurants = [];
    } else {
      _filteredRooms =
          _allRooms
              .where(
                (room) => room.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

      _filteredRestaurants =
          _allRestaurants
              .where(
                (rest) =>
                    rest.name?.toLowerCase().contains(query.toLowerCase()) ??
                    false,
              )
              .toList();
    }

    notifyListeners();
  }

  // ------------------ RESERVED ROOMS ------------------
  final List<HotelRoom> _reservedRooms = [];

  List<HotelRoom> get reservedRooms => List.unmodifiable(_reservedRooms);

  void reserveRoom(HotelRoom room) {
    if (!_reservedRooms.contains(room)) {
      _reservedRooms.add(room);
      notifyListeners();
    }
  }

  void cancelRoomReservation(HotelRoom room) {
    if (_reservedRooms.remove(room)) {
      notifyListeners();
    }
  }

  bool isRoomReserved(HotelRoom room) => _reservedRooms.contains(room);

  // ------------------ RESERVED RESTAURANTS ------------------
  final List<ResturantModel> _reservedRestaurants = [];

  List<ResturantModel> get reservedRestaurants =>
      List.unmodifiable(_reservedRestaurants);

  void reserveRestaurant(ResturantModel restaurant) {
    if (!_reservedRestaurants.contains(restaurant)) {
      _reservedRestaurants.add(restaurant);
      debugPrint("$reservedRestaurants");
      notifyListeners();
    }
  }

  void cancelRestaurantReservation(ResturantModel restaurant) {
    if (_reservedRestaurants.remove(restaurant)) {
      notifyListeners();
    }
  }

  bool isRestaurantReserved(ResturantModel restaurant) =>
      _reservedRestaurants.contains(restaurant);
}
