import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetListUserUseCase {
  final UserRepository repository;

  GetListUserUseCase(this.repository);

  Future<List<Future<User>>> call() async {
    return repository.getListUser();
  }
}
