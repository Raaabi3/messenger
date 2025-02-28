import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger/Controller/HomeController.dart';
import 'package:messenger/Views/Homescreen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Controller/ChatController.dart';
import 'Controller/ThemeProvider.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();
  final chatController = ChatController();
  await chatController.loadChats();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HomescreenController()),
                ChangeNotifierProvider(create: (_) => ChatController()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.blueGrey, // Change primary color
            scaffoldBackgroundColor: Colors.black, // Background color
            appBarTheme: AppBarTheme(backgroundColor: Colors.black),
            switchTheme: SwitchThemeData(
              thumbColor:
                  WidgetStateProperty.all(Colors.white), // Fix switch color
              trackColor: WidgetStateProperty.all(Colors.grey),
            ),
            
            colorScheme: ColorScheme.dark(
              primary: Colors.grey[900]!, // Fix default purple
              secondary: Colors.teal, // Accent color
              surface: Colors.grey[900]!,
            ),
          ),
          home: Homescreen(),
        );
      },
    );
  }
}
