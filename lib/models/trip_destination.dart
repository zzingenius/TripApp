class TripDestination {
  final int id;
  final String name;
  final String country;
  final String description;
  final String imagePath;
  final String discount;

  const TripDestination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.imagePath,
    required this.discount,
  });

  factory TripDestination.fromJson(Map<String, dynamic> json){
    return TripDestination(
        id: json['id'],
        name: json['name'],
        country: json['country'],
        description: json['description'],
        imagePath: json['imageUrl'],
        discount: json['discount']
    );
  }
}