import 'package:flutter/material.dart';
import 'package:sqflite_example/database/database_helper.dart';

// Agregamos las nuevas importaciones para las pantallas adicionales
import 'package:sqflite_example/screens/welcome_screen.dart';
import 'package:sqflite_example/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventario de Computadoras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Configuramos la pantalla de inicio y las rutas
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(), // Pantalla de bienvenida
        '/home': (context) =>
            const HomeScreen(), // Pantalla principal de inventario
      },
    );
  }
}
