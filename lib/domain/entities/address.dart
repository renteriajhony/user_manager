class Address {
  Address({
    required this.street,
    required this.city,
    required this.country,
    this.userId,
  });

  final String street;
  final String city;
  final String country;
  final String? userId;

  Address copyWith({
    String? street,
    String? city,
    String? country,
    String? userId,
  }) {
    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      country: country ?? this.country,
      userId: userId ?? this.userId,
    );
  }
}
