import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:user_namager/core/router/app_router.dart';
import 'package:user_namager/presentation/pages/pages.dart';

import '../../presentation/base_widget.dart';

void main() {
  late GoRouter router;

  setUpAll(() {
    router = appRouter;
  });

  testWidgets('Debe navegar a UserListPage cuando la ruta es "/"',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      baseWidgetRouter(),
    );

    // Verificar que UserListPage está presente en la pantalla
    expect(find.byType(UserListPage), findsOneWidget);
  });

  testWidgets('Debe navegar a UserFormPage con un idUser válido',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      baseWidgetRouter(router: router),
    );

    // Simular navegación a la pantalla de formulario con un id específico
    router.go('/addUser/123');
    await tester.pumpAndSettle();

    // Verificar que UserFormPage está en pantalla con el idUser correcto
    expect(find.byType(UserFormPage), findsOneWidget);
  });

  testWidgets('Debe pasar correctamente el parámetro idUser',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      baseWidgetRouter(router: router),
    );

    // Simular navegación a la pantalla de formulario con un id específico
    router.go('/addUser/456');
    await tester.pumpAndSettle();

    // Buscar el widget y extraer su argumento
    final userFormPage = tester.widget<UserFormPage>(find.byType(UserFormPage));

    expect(userFormPage.idUser, '456');
  });
}
