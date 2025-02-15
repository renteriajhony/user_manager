import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource _localDataSource;

  UserRepositoryImpl(this._localDataSource);

  @override
  Future<void> createUser(User user) async {
    await _localDataSource.insertUser(user);
  }

  @override
  Future<User?> getUser(String id) async {
    return await _localDataSource.getUserById(id);
  }

  @override
  Future<List<Future<User>>> getListUser() async {
    return await _localDataSource.getListUser();
  }
}
