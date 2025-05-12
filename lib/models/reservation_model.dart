class ReservationModel {
  String id;
  String eventId;
  DateTime reservationDate;

  ReservationModel({
    required this.id,
    required this.eventId,
    required this.reservationDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'reservationDate': reservationDate.toIso8601String(),
    };
  }

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      eventId: json['eventId'],
      reservationDate: DateTime.parse(json['reservationDate']),
    );
  }
}
