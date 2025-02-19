import 'package:flutter/material.dart';
import 'package:messenger/Controller/HomeController.dart';
import 'package:messenger/Views/Homescreen.dart';
import 'package:provider/provider.dart';

import 'Controller/ChatController.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ChatController()),
    ChangeNotifierProvider(create: (_) => HomescreenController()),

  ], child: MaterialApp(home: Homescreen())));
}
