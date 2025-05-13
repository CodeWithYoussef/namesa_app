class ResturantModel {
  String? name;
  String? imagePath;
  String? menuPath1;
  String? menuPath2;
  String? menuPath3;
  double? rating;
  double? reviews;
  bool favourite = false;

  ResturantModel({
    required this.name,
    required this.imagePath,
    required this.menuPath1,
    required this.menuPath2,
    required this.menuPath3,
    required this.rating,
    required this.reviews,
  });
}
