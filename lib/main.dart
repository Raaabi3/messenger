import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messenger/Controller/HomeController.dart';
import 'package:messenger/Views/Homescreen.dart';
import 'package:provider/provider.dart';
import 'Controller/ChatController.dart';
import 'Controller/ThemeProvider.dart';
import 'Models/Chat.dart';
import 'Models/ChatMessage.dart';
import 'adapters/DurationAdapter.dart';
import 'Models/Helpers/Message.dart';
import 'Models/RuleModel.dart';
import 'adapters/TimeOfDay.dart';

void registerAdapters() {
  Hive.registerAdapter(DurationAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(RuleModelAdapter());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerAdapters();
/*
  // Delete existing boxes to avoid schema mismatch
  await Hive.deleteBoxFromDisk('messages');
  await Hive.deleteBoxFromDisk('chats');
  await Hive.deleteBoxFromDisk('rule_model_box');
*/
  // Register Adapters for Hive (only if not already registered)
  if (!Hive.isAdapterRegistered(MessageAdapter().typeId)) {
    Hive.registerAdapter(MessageAdapter());
  }
  if (!Hive.isAdapterRegistered(ChatAdapter().typeId)) {
    Hive.registerAdapter(ChatAdapter());
  }
  if (!Hive.isAdapterRegistered(ChatMessageAdapter().typeId)) {
    Hive.registerAdapter(ChatMessageAdapter());
  }

  

  // Open Hive Boxes
  await Hive.openBox('messages'); // Store messages safely
  await Hive.openBox<Chat>('chats'); // Store chat history
  await Hive.openBox<RuleModel>(
      'rule_model_box'); // Use the same name everywhere

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HomescreenController()),
        ChangeNotifierProxyProvider<HomescreenController, ChatController>(
          create: (_) =>
              ChatController(homescreenController: HomescreenController()),
          update: (_, homescreenController, chatController) {
            chatController ??=
                ChatController(homescreenController: homescreenController);
            return chatController;
          },
        ),
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
            primaryColor: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(backgroundColor: Colors.black),
            dialogTheme: DialogTheme(
              backgroundColor: Colors.grey[800],
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    textStyle: TextStyle(color: Colors.white))),
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(Colors.white),
              trackColor: MaterialStateProperty.all(Colors.grey),
            ),
            colorScheme: ColorScheme.dark(
              primary: Colors.grey[900]!,
              secondary: Colors.teal,
              surface: Colors.grey[900]!,
            ),
          ),
          home: Homescreen(),
        );
      },
    );
  }
}
