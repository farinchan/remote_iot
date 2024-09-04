import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_remote/presentation/bloc/relay/relay_bloc.dart';
import 'package:iot_remote/presentation/pages/relay_page.dart';
import 'package:iot_remote/presentation/pages/sidemenu.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RelayBloc(),
        )
      ],
      child: MaterialApp.router(
        title: 'Flutter Seminar IOT ORBIT',
        routerConfig: GoRouter(routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SideMenu(),
            routes: [
              GoRoute(
                path: 'relay',
                builder: (context, state) => RelayPage(),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
