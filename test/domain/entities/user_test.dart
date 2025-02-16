import 'package:flutter_test/flutter_test.dart';
import 'package:user_namager/domain/entities/user.dart';

void main() {
  group('User Entity', () {
    final user = User(
      id: '123',
      name: 'John',
      lastName: 'Doe',
      birthDate: DateTime(1990, 1, 1),
    );

    test('should create a User instance', () {
      expect(user.id, '123');
      expect(user.name, 'John');
      expect(user.lastName, 'Doe');
      expect(user.birthDate, DateTime(1990, 1, 1));
      expect(user.addresses, isEmpty);
      expect(user.isViewDetail, isFalse);
    });

    test('should copy a User instance with new values', () {
      final updatedUser = user.copyWith(
        name: 'Jane',
        isViewDetail: true,
      );

      expect(updatedUser.id, '123');
      expect(updatedUser.name, 'Jane');
      expect(updatedUser.lastName, 'Doe');
      expect(updatedUser.birthDate, DateTime(1990, 1, 1));
      expect(updatedUser.addresses, isEmpty);
      expect(updatedUser.isViewDetail, isTrue);
    });

    test('should copy a User instance with the same values', () {
      final copiedUser = user.copyWith();

      expect(copiedUser.id, '123');
      expect(copiedUser.name, 'John');
      expect(copiedUser.lastName, 'Doe');
      expect(copiedUser.birthDate, DateTime(1990, 1, 1));
      expect(copiedUser.addresses, isEmpty);
      expect(copiedUser.isViewDetail, isFalse);
    });
  });
}
