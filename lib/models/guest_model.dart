import 'reservation_model.dart'; // Make sure this is correct based on your file structure

class GuestModel {
  String? id;
  String? name;
  String? mail;
  List<ReservationModel>? reservations;

  GuestModel({
    required this.id,
    required this.name,
    required this.mail,
    required this.reservations,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json, String id) {
    return GuestModel(
      id: id,
      name: json['name'],
      mail: json['mail'],
      reservations:
          (json['reservations'] as List<dynamic>?)
              ?.map((resJson) => ReservationModel.fromJson(resJson))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mail': mail,
      'reservations': reservations?.map((res) => res.toJson()).toList(),
    };
  }
}
