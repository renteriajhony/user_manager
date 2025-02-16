import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_namager/domain/entities/user.dart';
import 'package:user_namager/presentation/pages/widgets/list_address.dart';

import '../../providers/user_provider.dart';

class ListUser extends ConsumerStatefulWidget {
  const ListUser({super.key});

  @override
  ConsumerState<ListUser> createState() => _ListUserState();
}

class _ListUserState extends ConsumerState<ListUser> {
  List<bool> isViewDetailList = [];

  @override
  Widget build(BuildContext context) {
    final List<User>? listUser = ref.watch(userListProvider);
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Theme.of(context).colorScheme.secondary,
        thickness: 0.1,
        indent: 10,
        endIndent: 10,
      ),
      itemCount: listUser!.length,
      itemBuilder: (context, index) {
        final user = listUser[index];
        isViewDetailList.add(user.isViewDetail);
        return Card(
          elevation: 4,
          color: Theme.of(context).colorScheme.surface,
          child: ListTile(
            onTap: () => context.go('/addUser/${user.id}'),
            title: Text('${user.name} ${user.lastName}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Cumpleaños: ',
                    style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.primary),
                    children: [
                      TextSpan(
                        text: user.birthDate.toString().split(' ')[0],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ), 
                ),
                Divider(),
                !isViewDetailList[index]
                    ? SizedBox()
                    : LitstAddress(listAddress: user.addresses)
              ],
            ),
            trailing: IconButton(
              key: Key('$user.id'),
              icon: isViewDetailList[index]
                  ? Icon(Icons.keyboard_arrow_down)
                  : Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                isViewDetailList[index] = !isViewDetailList[index];
              },
            ),
            leading: CircleAvatar(
              child: Text('${user.name[0]}${user.name[1]}'),
            ),
            style: ListTileStyle.list,
          ),
        );
      },
    );
  }
}
