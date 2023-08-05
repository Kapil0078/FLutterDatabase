import 'package:database_flutter/constant.dart';
import 'package:database_flutter/pages/create_update_note.dart';
import 'package:database_flutter/pages/note_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFlite',
      theme: ThemeData(
        primarySwatch: primary,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primary),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.brown.shade50,
        appBarTheme: AppBarTheme(
          color: Colors.orange.shade400,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return NoteScreen();
  }
}
