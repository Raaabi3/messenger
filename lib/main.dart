import 'package:flutter/material.dart';
import 'package:messenger/Views/Homescreen.dart';
import 'package:provider/provider.dart';

import 'Controller/ChatController.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ChatController(),
      child: MaterialApp(home: Homescreen())));
}
