import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_namager/presentation/pages/user_form_page.dart';
import 'package:user_namager/presentation/pages/widgets/widgets.dart';

import '../base_widget.dart';

void main() {
  testWidgets('Renderizado de crear UserFormPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      baseWidgetApp(
        home: UserFormPage(idUser: ''),
      ),
    );

    expect(find.text('Crear Usuario'), findsOneWidget);
  });

  testWidgets('Renderizado de actualizar UserFormPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      baseWidgetApp(
        home: UserFormPage(idUser: 'idUser'),
      ),
    );

    expect(find.text('Actualizar Usuario'), findsOneWidget);
  });

  testWidgets('UserFormPage shows error when form is incomplete',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(baseWidgetApp(home: UserFormPage(idUser: 'testUserId')));

    await tester.tap(find.byIcon(Icons.save_as_outlined));
    await tester.pump();

    expect(find.text('Datos del usuario incompletos'), findsOneWidget);
  });

  group('UserFormPage Boton guardar', () {
    testWidgets('Formulario invalido', (WidgetTester tester) async {
      await tester.pumpWidget(
        baseWidgetApp(
          home: UserFormPage(idUser: ''),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), '');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(2), '2000-01-01');

      await tester.tap(find.byIcon(Icons.save_as_outlined));
      await tester.pump();

      expect(UserFormPage.formUserKey.currentState?.validate(), false);
      expect(AddressWidget.formAddressKey.currentState?.validate(), false);
    });

    testWidgets('Formulario valido', (WidgetTester tester) async {
      await tester.pumpWidget(
        baseWidgetApp(
          home: UserFormPage(idUser: ''),
        ),
      );

      final txtName = find.byKey(Key('user_txt_name'));
      await tester.enterText(txtName, 'Mike');
      final txtLastName = find.byKey(Key('user_txt_lastname'));
      await tester.enterText(txtLastName, 'Doe');
      final txtBirtday = find.byKey(Key('user_txt_birtday'));
      await tester.tap(txtBirtday);
      await tester.pump();

      await tester.tap(find.text('OK'));
      await tester.pump();

      await tester.enterText(find.byKey(Key('address_street')), 'Calle 56');
      await tester.enterText(find.byKey(Key('address_city')), 'Cali');
      await tester.enterText(find.byKey(Key('address_country')), 'Colombia');

      await tester.tap(find.byKey(Key('address_btn_add')));
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.save_as_outlined));
      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(txtName, findsOneWidget);
    });

     testWidgets('Formulario valido update', (WidgetTester tester) async {
      await tester.pumpWidget(
        baseWidgetApp(
          home: UserFormPage(idUser: '123'),
        ),
      );

      final txtName = find.byKey(Key('user_txt_name'));
      await tester.enterText(txtName, 'Mike');
      final txtLastName = find.byKey(Key('user_txt_lastname'));
      await tester.enterText(txtLastName, 'Doe');
      final txtBirtday = find.byKey(Key('user_txt_birtday'));
      await tester.tap(txtBirtday);
      await tester.pump();

      await tester.tap(find.text('OK'));
      await tester.pump();

      await tester.enterText(find.byKey(Key('address_street')), 'Calle 56');
      await tester.enterText(find.byKey(Key('address_city')), 'Cali');
      await tester.enterText(find.byKey(Key('address_country')), 'Colombia');

      await tester.tap(find.byKey(Key('address_btn_add')));
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.save_as_outlined));
      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(txtName, findsOneWidget);
    });
  });
}
