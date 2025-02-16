import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_namager/core/router/app_router.dart';

Widget baseWidgetRouter({GoRouter? router}) => ProviderScope(
      child: MaterialApp.router(
        routerConfig: router ?? appRouter,
      ),
    );

Widget baseWidgetApp({required Widget home}) => ProviderScope(
      child: MaterialApp(
        home: home,
      ),
    );
