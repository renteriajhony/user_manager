import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/presentation/providers/addres_provider.dart';
import 'package:user_namager/presentation/providers/user_provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/address.dart';
import '../../domain/usecases/usecases.dart';

class UserPresenter extends StateNotifier<User?> {
  final CreateUserUseCase _createUserUseCase;
  final GetUserUseCase _getUserUseCase;

  UserPresenter(this._createUserUseCase, this._getUserUseCase) : super(null);

  Future<void> setUserState(String id, String name, String lastName,
      String birthDate, List<Address> address) async {
    final user = User(
      id: id,
      name: name,
      lastName: lastName,
      birthDate: DateTime.parse(birthDate),
      addresses: address,
    );
    state = user;
  }

  Future<void> createUser(User user) async {
    await _createUserUseCase(user);
    state = user;
  }

  Future<User?> loadUser(String id) async {
    final user = await _getUserUseCase(id);
    if (user != null) {
      state = user;
    }
    return user;
  }

  Future<bool> saveUser(WidgetRef ref) async {
    final addressListState = ref.read(addressListProvider);
    final user = ref.read(userPresenterProvider);
    if (user == null) return false;

    await ref.read(userPresenterProvider.notifier).createUser(user);

    await ref
        .read(addressListProvider.notifier)
        .createListAddress(addressListState.addresses, user.id);
    return true;
  }
}
