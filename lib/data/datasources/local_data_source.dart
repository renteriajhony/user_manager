import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../domain/entities/user.dart';
import '../../domain/entities/address.dart';

part 'local_data_source.g.dart';

@DataClassName("UserModel")
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get lastName => text()();
  DateTimeColumn get birthDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName("AddressModel")
class Addresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().customConstraint('REFERENCES users(id)')();
  TextColumn get street => text()();
  TextColumn get city => text()();
  TextColumn get country => text()();
}

@DriftDatabase(tables: [Users, Addresses])
class LocalDataSource extends _$LocalDataSource {
  LocalDataSource() : super(_openConnection());

  LocalDataSource.forTesting(super.db);

  @override
  int get schemaVersion => 1;

  /// **Método para obtener lista de usuarios**
  Future<List<Future<User>>> getListUser() async {
    final query = await (select(users)).get();
    return query.map((row) async {
      List<Address> userAddresses = await getUserAddresses(row.id);
      return User(
        id: row.id,
        name: row.name,
        lastName: row.lastName,
        birthDate: row.birthDate,
        addresses: userAddresses,
      );
    }).toList();
  }

  /// **Método para insertar un usuario**
  Future<void> insertUser(User user) async {
    await (delete(users)..where((tbl) => tbl.id.equals(user.id))).go();
    await into(users).insert(
      UsersCompanion(
        id: Value(user.id),
        name: Value(user.name),
        lastName: Value(user.lastName),
        birthDate: Value(user.birthDate),
      ),
    );
  }

  /// **Método para obtener un usuario por ID**
  Future<User?> getUserById(String id) async {
    final query =
        await (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
    if (query == null) return null;
    final userAddresses = await getUserAddresses(id);
    return User(
      id: query.id,
      name: query.name,
      lastName: query.lastName,
      birthDate: query.birthDate,
      addresses: userAddresses,
    );
  }

  /// **Método para insertar una dirección**
  Future<void> insertListAddress(List<Address> address, String userId) async {
    await (delete(addresses)..where((tbl) => tbl.userId.equals(userId))).go();
    await batch((batch) {
      for (var a in address) {
        batch.insert(
            addresses,
            AddressesCompanion(
              userId: Value(userId),
              street: Value(a.street),
              city: Value(a.city),
              country: Value(a.country),
            ));
      }
    });
  }

  /// **Método para insertar una dirección**
  Future<void> insertAddress(Address address) async {
    await into(addresses).insert(AddressesCompanion(
      userId: Value(address.userId ?? ''),
      street: Value(address.street),
      city: Value(address.city),
      country: Value(address.country),
    ));
  }

  /// **Método para obtener las direcciones de un usuario**
  Future<List<Address>> getUserAddresses(String userId) async {
    try {
      final query = await (select(addresses)
            ..where((a) => a.userId.equals(userId)))
          .get();
      return query
          .map((row) => Address(
                userId: row.userId,
                street: row.street,
                city: row.city,
                country: row.country,
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }
}

/// **Método para inicializar la base de datos**
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}
