import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/providers/usecase_providers.dart';
import '../presenters/user_list_presenter.dart';
import '../presenters/user_presenter.dart';

// Proveedor de UserPresenter, conecta con los casos de uso
final userListPresenterProvider =
    StateNotifierProvider<UserListPresenter, List<User>?>((ref) {
  final getUserList = ref.watch(getListUserUseCaseProvider);
  return UserListPresenter(getUserList);
});

// Proveedor de listado de usuarios
final userListProvider = Provider<List<User>?>((ref) {
  return ref.watch(userListPresenterProvider);
});

// Proveedor de UserPresenter, conecta con los casos de uso
final userPresenterProvider =
    StateNotifierProvider<UserPresenter, User?>((ref) {
  final createUser = ref.watch(createUserUseCaseProvider);
  final getUser = ref.watch(getUserUseCaseProvider);
  return UserPresenter(createUser, getUser);
});

// Proveedor de estado del usuario actual
final userProvider = Provider<User?>((ref) {
  return ref.watch(userPresenterProvider);
});

// Método para crear un usuario desde la UI
final createUserProvider = Provider((ref) {
  return (
    User user,
  ) {
    return ref.read(userPresenterProvider.notifier).createUser(user);
  };
});

// Método para cargar un usuario desde la base de datos
final loadUserProvider = Provider((ref) {
  return (String id) {
    return ref.read(userPresenterProvider.notifier).loadUser(id);
  };
});
