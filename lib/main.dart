import 'package:flutter/material.dart';
import 'providers/AuthProvider.dart';
import 'providers/CategoryProvider.dart';
import 'providers/TransactionProvider.dart';
import 'pages/categories.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<CategoryProvider>(
                    create: (context) => CategoryProvider(authProvider)),
                ChangeNotifierProvider<TransactionProvider>(
                    create: (context) => TransactionProvider(authProvider))
              ],
              child: MaterialApp(title: 'Bienvenue sur reCESIpes', routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  if (authProvider.isAuthenticated) {
                    return Home();
                  } else {
                    return Login();
                  }
                },
                '/login': (context) => Login(),
                '/register': (context) => Register(),
                '/home': (context) => Home(),
                '/categories': (context) => Categories(),
              }));
        }));
  }
}
