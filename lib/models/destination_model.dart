import 'package:equatable/equatable.dart';

class DestinationModel extends Equatable {
  const DestinationModel(
      {required this.id,
      required this.nameDestination,
      required this.city,
      required this.imageUrl,
      this.rating = 0.0,
      this.price = 0});

  final String id;
  final String nameDestination;
  final String city;
  final String imageUrl;
  final double rating;
  final int price;

  factory DestinationModel.fromJson(String id, Map<String, dynamic> json) =>
      DestinationModel(
        id: id,
        nameDestination: json['nameDestination'],
        city: json['city'],
        imageUrl: json['imageUrl'],
        rating: json['rating'].toDouble(),
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameDestination': nameDestination,
        'city': city,
        'imageUrl': imageUrl,
        'rating': rating,
        'price': price,
      };

  @override
  List<Object?> get props =>
      [id, nameDestination, city, imageUrl, rating, price];
}
