import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/domain/entities/address.dart';
import 'package:user_namager/presentation/pages/widgets/list_address.dart';

void main() {
  testWidgets('ListAddress displays addresses correctly',
      (WidgetTester tester) async {
    // Arrange
    final addresses = [
      Address(
        street: '123 Main St',
        city: 'Springfield',
        country: 'USA',
      ),
      Address(
        street: '456 Elm St',
        city: 'Shelbyville',
        country: 'USA',
      ),
    ];

    // Act
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: LitstAddress(listAddress: addresses),
          ),
        ),
      ),
    );

    // Assert
    expect(find.byKey(Key('USA_0')), findsOneWidget);
    expect(find.byKey(Key('USA_1')), findsOneWidget);
  });
}
