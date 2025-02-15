import 'package:user_namager/domain/entities/address.dart';

class User {
  final String id;
  final String name;
  final String lastName;
  final DateTime birthDate;
  final List<Address> addresses;
  bool isViewDetail;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.birthDate,
    this.addresses = const [],
    this.isViewDetail = false,
  });

  User copyWith({
    String? id,
    String? name,
    String? lastName,
    DateTime? birthDate,
    List<Address>? addresses,
    bool? isViewDetail,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      addresses: addresses ?? this.addresses,
      isViewDetail: isViewDetail ?? this.isViewDetail,
    );
  }
}
