import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/domain/entities/address.dart';
import 'package:user_namager/domain/entities/user.dart';
import 'package:user_namager/presentation/pages/widgets/list_user.dart';
import 'package:user_namager/presentation/providers/providers.dart';

void main() {
  testWidgets('ListUser displays user details and toggles view',
      (WidgetTester tester) async {
    final mockUsers = [
      User(
          id: '1',
          name: 'John',
          lastName: 'Doe',
          birthDate: DateTime(1990, 1, 1),
          addresses: [
            Address(
              street: '123 Main St',
              city: 'Springfield',
              country: 'USA',
              userId: '1',
            ),
            Address(
              street: '456 Elm St',
              city: 'Shelbyville',
              country: 'USA',
              userId: '1',
            ),
          ],
          isViewDetail: false),
      User(
          id: '2',
          name: 'Jane',
          lastName: 'Smith',
          birthDate: DateTime(1985, 5, 15),
          addresses: [
            Address(
              street: '123 c',
              city: 'Cali',
              country: 'COLOMBIA',
              userId: '2',
            )
          ],
          isViewDetail: false),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userListProvider.overrideWithValue(mockUsers),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: ListUser(),
          ),
        ),
      ),
    );

    expect(find.byKey(Key('1_0')), findsOneWidget);
    expect(find.byKey(Key('2_1')), findsOneWidget);
  });
}
