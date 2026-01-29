
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopify/features/bloc/bloc/cart/bloc/cart_bloc.dart';
import 'package:shopify/features/bloc/bloc/home_bloc.dart';
import 'package:shopify/features/ui/home_page.dart';
import 'package:shopify/features/ui/homescreen.dart';
import 'package:shopify/features/ui/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();

  await Hive.openBox('logindata');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => CartBloc()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     final box = Hive.box('logindata');
    final currentUser = box.get('currentUser');
       return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: currentUser == null
          ? const LoginPage()
          : HomePage(
              userName: box
                  .get('users', defaultValue: [])
                  .firstWhere((u) => u['email'] == currentUser)['name'],
            ),
    );
  }
}
