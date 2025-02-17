import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_namager/presentation/pages/widgets/list_user.dart';
import 'package:user_namager/presentation/presenters/user_list_presenter.dart';

import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<User>? listUser = ref.watch(userListProvider);
    UserListPresenter userListPresenter =
        ref.read(userListPresenterProvider.notifier);
    userListPresenter.loadListUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de usuarios'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: userListPresenter.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  key: Key('louder_user_list'),
                ),
              )
            : (listUser?.length ?? 0) == 0
                ? Center(
                    key: Key('empty_user_list'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/addfile.png',
                          width: 200,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          'Agrega un usuario',
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                  )
                : ListUser(
                    key: Key('all_user_list'),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/addUser/ ');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
