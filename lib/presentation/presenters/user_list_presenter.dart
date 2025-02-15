import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/domain/usecases/get_list_user_use_case.dart';
import '../../domain/entities/user.dart';

class UserListPresenter extends StateNotifier<List<User>?> {
  final GetListUserUseCase _getListUserUseCase;

  UserListPresenter(
    this._getListUserUseCase,
  ) : super(null);

  bool isLoading = true;

  Future<bool> loadListUser() async {
    final List<Future<User>> listUser = await _getListUserUseCase();
    isLoading = false;
    if (listUser.isNotEmpty) {
      final List<User> users = await Future.wait(listUser);
      state = users;
    } else {
      state = [];
    }

    return isLoading;
  }
}
