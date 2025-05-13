class HotelRoom {
  String? name;
  double? price;
  String? imagePath;
  double? rating;
  double? reviews;
  double? numOfBeds;
  bool? wifi;
  bool? gym;
  bool favourite = false;

  // Constructor
  HotelRoom({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.reviews,
    required this.numOfBeds,
    this.wifi = false,
    this.gym = false,
  });
}
