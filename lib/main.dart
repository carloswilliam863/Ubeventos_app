import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/produto_screen.dart'; // Importando a tela de produtos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      initialRoute: '/login', // A rota inicial é a tela de login
      routes: {
        '/login': (context) => const LoginScreen(),      
        '/produtos': (context) => const ProductScreen(),   
      },
    );
  }
}
