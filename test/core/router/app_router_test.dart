import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_namager/core/router/app_router.dart';
import 'package:user_namager/presentation/pages/pages.dart';

void main() {
  testWidgets('Debe navegar a UserListPage cuando la ruta es "/"', (WidgetTester tester) async {
    final router = appRouter;

    await tester.pumpWidget(
      ProviderScope( // 🔥 Envuelve en ProviderScope
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Verificar que UserListPage está presente en la pantalla
    expect(find.byType(UserListPage), findsOneWidget);
  });

  testWidgets('Debe navegar a UserFormPage con un idUser válido', (WidgetTester tester) async {
    final router = appRouter;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Simular navegación a la pantalla de formulario con un id específico
    router.go('/addUser/123');
    await tester.pumpAndSettle();

    // Verificar que UserFormPage está en pantalla con el idUser correcto
    expect(find.byType(UserFormPage), findsOneWidget);
  });

  testWidgets('Debe pasar correctamente el parámetro idUser', (WidgetTester tester) async {
    final router = appRouter;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Simular navegación a la pantalla de formulario con un id específico
    router.go('/addUser/456');
    await tester.pumpAndSettle();

    // Buscar el widget y extraer su argumento
    final userFormPage = tester.widget<UserFormPage>(find.byType(UserFormPage));

    expect(userFormPage.idUser, '456');
  });
}
