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
import 'Models/Helpers/Message.dart';
import 'Models/RuleModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

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
  
    if (!Hive.isAdapterRegistered(RuleModelAdapter().typeId)) {
    Hive.registerAdapter(RuleModelAdapter()); 
    print('RuleAdapter registered');
  }
  

  // Open Hive Boxes only if not already open
  if (!Hive.isBoxOpen('messages')) {
    await Hive.openBox('messages'); // Store messages safely
  }
  if (!Hive.isBoxOpen('chats')) {
    await Hive.openBox<Chat>('chats'); // Store chat history
  }
   if (!Hive.isBoxOpen('rules')) {
    await Hive.openBox<RuleModel>('rule_model_box'); // Store rules
  }

  final chatController = ChatController();
  chatController.loadChats(); // No need for `await` since `loadChats` is now synchronous

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HomescreenController()),
        ChangeNotifierProvider(create: (_) => chatController),
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