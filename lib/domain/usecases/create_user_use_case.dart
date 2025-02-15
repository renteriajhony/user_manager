import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase(this.repository);

  Future<void> call(User user) async {
    return repository.createUser(user);
  }
}
