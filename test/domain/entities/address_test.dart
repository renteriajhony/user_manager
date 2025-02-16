import 'package:flutter_test/flutter_test.dart';
import 'package:user_namager/domain/entities/address.dart';

void main() {
  group('Address', () {
    test('should create an Address instance', () {
      final address = Address(
        street: '123 Main St',
        city: 'Springfield',
        country: 'USA',
        userId: 'user123',
      );

      expect(address.street, '123 Main St');
      expect(address.city, 'Springfield');
      expect(address.country, 'USA');
      expect(address.userId, 'user123');
    });

    test('should copy an Address instance with new values', () {
      final address = Address(
        street: '123 Main St',
        city: 'Springfield',
        country: 'USA',
        userId: 'user123',
      );

      final updatedAddress = address.copyWith(
        street: '456 Elm St',
        city: 'Shelbyville',
      );

      expect(updatedAddress.street, '456 Elm St');
      expect(updatedAddress.city, 'Shelbyville');
      expect(updatedAddress.country, 'USA');
      expect(updatedAddress.userId, 'user123');
    });

    test(
        'should copy an Address instance with same values if no new values are provided',
        () {
      final address = Address(
        street: '123 Main St',
        city: 'Springfield',
        country: 'USA',
        userId: 'user123',
      );

      final copiedAddress = address.copyWith();

      expect(copiedAddress.street, '123 Main St');
      expect(copiedAddress.city, 'Springfield');
      expect(copiedAddress.country, 'USA');
      expect(copiedAddress.userId, 'user123');
    });
  });
}
