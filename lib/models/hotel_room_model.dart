class HotelRoom {
  final String id; // Unique ID for comparison
  final String name;
  final double price;
  final String imagePath;
  final double rating;
  final double reviews;
  final double numOfBeds;
  final bool wifi;
  final bool gym;

  HotelRoom({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.rating = 0.0,
    this.reviews = 0.0,
    this.numOfBeds = 1.0,
    this.wifi = false,
    this.gym = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HotelRoom &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
