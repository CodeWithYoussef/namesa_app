import 'package:flutter/cupertino.dart';
import 'package:namesa_yassin_preoject/models/hotel_room_model.dart';
import 'package:namesa_yassin_preoject/models/resturant_model.dart';

class HotelRooms extends ChangeNotifier {
  // ------------------ ROOMS ------------------

  final List<HotelRoom> allRooms = [
    HotelRoom(
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

  bool isFavouriteRoom(HotelRoom room) {
    return _favouriteRooms.contains(room);
  }

  // ------------------ RESTAURANTS ------------------

  final List<ResturantModel> allResturant = [
    ResturantModel(
      name: "Atlas Palace",
      imagePath: "assets/RESTURANTS/Atlas Palace.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.7,
      reviews: 360,
    ),
    ResturantModel(
      name: "Flame Of Royale",
      imagePath: "assets/RESTURANTS/Flame Of Royale.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.8,
      reviews: 480,
    ),
    ResturantModel(
      name: "Golden Palace",
      imagePath: "assets/RESTURANTS/Golden Palac.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.5,
      reviews: 320,
    ),
    ResturantModel(
      name: "Rehab Palace",
      imagePath: "assets/RESTURANTS/Rehab Horizon.jpg",
      menuPath1: "assets/menus/Rehab Horizon menu 1.jpg",
      menuPath2: "assets/menus/Rehab Horizon menu 2.jpg",
      menuPath3: "assets/menus/Rehab Horizon menu 3.jpg",
      rating: 4.9,
      reviews: 930,
    ),
    ResturantModel(
      name: "The Impier Dragon",
      imagePath: "assets/RESTURANTS/The Impier Dragon.jpg",
      menuPath1: "",
      menuPath2: "",
      menuPath3: "",
      rating: 4.4,
      reviews: 1060,
    ),
  ];

  final List<ResturantModel> _favouriteRestaurants = [];
  List<ResturantModel> get favouriteRestaurants => List.unmodifiable(_favouriteRestaurants);

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

  bool isFavouriteRestaurant(ResturantModel restaurant) {
    return _favouriteRestaurants.contains(restaurant);
  }
}
