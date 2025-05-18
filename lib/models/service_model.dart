class ServiceModel {
  final String uid;
  final bool? roomService;
  final bool? foodDelivery;
  final bool? laundry;
  final bool? needService;
  late final bool? isDone;
  final double extraPrice;
  final String? username;
  final double roomPrice;

  ServiceModel({
    required this.uid,
    this.username,
    this.roomService,
    this.foodDelivery,
    this.laundry,
    this.needService,
    this.isDone,
    this.extraPrice = 0.0,
    this.roomPrice=0.0
  });

  factory ServiceModel.fromMap(Map<String, dynamic> data) {
    return ServiceModel(
      uid: data['uid'] ?? '',
      roomService: data['Room Service'],
      foodDelivery: data['foodDelivery'],
      laundry: data['laundry'],
      needService: data['needService'],
      isDone: data['ServiceDone'],
      extraPrice: (data['extraPrice'] ?? 0).toDouble(),
      roomPrice: (data['price']?? 0).toDouble(),
    );
  }
}
