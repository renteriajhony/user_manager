import 'package:flutter_test/flutter_test.dart';
import 'package:user_namager/data/datasources/local_data_source.dart';
import 'package:user_namager/domain/entities/user.dart';
import 'package:user_namager/domain/entities/address.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';

void main() {
  late LocalDataSource localDataSource;
  late List<Address> addreses;

  setUp(() {
    localDataSource = LocalDataSource.forTesting(NativeDatabase.memory());
  });

  setUpAll(() {
    addreses = [
      Address(street: 'Calle 56 # 84-33', city: 'Cali', country: 'Colombia'),
      Address(
          street: 'Calle 56 # 84-34', city: 'Medellin', country: 'Colombia'),
      Address(street: 'Calle 56 # 84-35', city: 'Bogota', country: 'Colombia'),
    ];
  });

  tearDown(() async {
    await localDataSource.close();
  });

  test('Debe insertar y obtener un usuario correctamente', () async {
    final user = User(
      id: '1',
      name: 'Juan',
      lastName: 'Pérez',
      birthDate: DateTime(1990, 5, 20),
      addresses: addreses,
    );

    await localDataSource.insertUser(user);
    final retrievedUser = await localDataSource.getUserById('1');

    expect(retrievedUser, isNotNull);
    expect(retrievedUser!.name, equals('Juan'));
    expect(retrievedUser.lastName, equals('Pérez'));
  });

  test('Debe insertar y obtener direcciones de un usuario', () async {
    final address = Address(
      userId: '1',
      street: 'Calle 123',
      city: 'Ciudad A',
      country: 'País B',
    );

    await localDataSource.insertAddress(address);
    final addresses = await localDataSource.getUserAddresses('1');

    expect(addresses, isNotEmpty);
    expect(addresses.first.street, equals('Calle 123'));
  });

  test('Debe eliminar y verificar que no existan direcciones', () async {
    final address = Address(
      userId: '1',
      street: 'Calle 123',
      city: 'Ciudad A',
      country: 'País B',
    );

    await localDataSource.insertAddress(address);
    await localDataSource.insertListAddress([], '1'); // Vacía las direcciones
    final addresses = await localDataSource.getUserAddresses('1');

    expect(addresses, isEmpty);
  });

  test('Debe obtener la lista de usuarios correctamente', () async {
    final user1 = User(
      id: '1',
      name: 'Juan',
      lastName: 'Pérez',
      birthDate: DateTime(1990, 5, 20),
      addresses: addreses,
    );

    final user2 = User(
      id: '2',
      name: 'Ana',
      lastName: 'Gómez',
      birthDate: DateTime(1985, 3, 15),
      addresses: addreses,
    );

    await localDataSource.insertUser(user1);
    await localDataSource.insertUser(user2);

    final users = await localDataSource.getListUser();

    expect(users, isNotEmpty);
    expect(users.length, equals(2));

    final retrievedUser1 = await users[0];
    final retrievedUser2 = await users[1];

    expect(retrievedUser1.name, equals('Juan'));
    expect(retrievedUser2.name, equals('Ana'));
  });
}