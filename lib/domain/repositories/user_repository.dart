import '../entities/user.dart';

abstract class UserRepository {
  Future<void> createUser(User user);
  Future<User?> getUser(String id);
  Future<List<Future<User>>> getListUser();
}
