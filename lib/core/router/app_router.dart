import 'package:go_router/go_router.dart';

import '../../presentation/pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => UserListPage(),
    ),
    GoRoute(
      path: '/addUser/:idUser',
      builder: (context, state) {
        final idUser = state.pathParameters['idUser'] ?? '';
        return UserFormPage(idUser: idUser);
      },
    ),
  ],
);
