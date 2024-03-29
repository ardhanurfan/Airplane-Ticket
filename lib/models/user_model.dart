import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel(
      {required this.id,
      required this.email,
      required this.name,
      this.hobby = '',
      this.balance = 0,
      this.imagePath = ''});

  final String id;
  final String email;
  final String name;
  final String hobby;
  final int balance;
  final String imagePath;

  @override
  List<Object?> get props => [id, email, name, hobby, balance, imagePath];
}
