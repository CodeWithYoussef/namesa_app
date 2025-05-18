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



  // New fields
    bool? roomService;
    bool? foodDelivery;
    bool? laundry;
    double extraPrice;
    bool? needService;
    bool?isDone;
    String? uid;
  HotelRoom({
    this.uid=" ",
    this.isDone=false,
    this. needService=true,
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.rating = 0.0,
    this.reviews = 0.0,
    this.numOfBeds = 1.0,
    this.wifi = false,
    this.gym = false,
    this.laundry = false,
    this.roomService = false,    // default value
    this.foodDelivery = false,   // default value
    this.extraPrice = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelRoom && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
