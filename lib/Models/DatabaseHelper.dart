import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/Chat.dart';
import '../Models/ChatMessage.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'chats.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE chats(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT,
        username TEXT,
        lastMessage TEXT,
        status INTEGER,
        received INTEGER,
        read INTEGER,
        time TEXT,
        lastSeenTime TEXT,
        mute INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chatId INTEGER,
        sentMessage TEXT,
        receivedMessage TEXT,
        sentMessageTime TEXT,
        receivedMessageTime TEXT,
        FOREIGN KEY(chatId) REFERENCES chats(id)
      )
    ''');
  }

  // Save a chat to the database
  Future<int> saveChat(Chat chat) async {
    final db = await database;

    final chatId = await db.insert('chats', {
      'imagePath': chat.image,
      'username': chat.username,
      'lastMessage': chat.lastmessage,
      'status': chat.status! ? 1 : 0,
      'received': chat.received! ? 1 : 0,
      'read': chat.read! ? 1 : 0,
      'time': chat.time?.toIso8601String(),
      'lastSeenTime': chat.lastSeenTime?.toIso8601String(),
      'mute': chat.mute! ? 1 : 0,
    });

    if (chat.conversations != null) {
      for (var message in chat.conversations!) {
        await db.insert('messages', {
          'chatId': chatId,
          'sentMessage': message.sentMessage,
          'receivedMessage': message.receivedMessage,
          'sentMessageTime': message.sentMessageTime?.toIso8601String(),
          'receivedMessageTime': message.receivedMessageTime?.toIso8601String(),
        });
      }
    }

    return chatId;
  }

  // Load all chats from the database
  Future<List<Chat>> loadChats() async {
    final db = await database;

    final List<Map<String, dynamic>> chatMaps = await db.query('chats');
    final List<Chat> chats = [];

    for (var chatMap in chatMaps) {
      final chatId = chatMap['id'];
      final List<Map<String, dynamic>> messageMaps = await db.query(
        'messages',
        where: 'chatId = ?',
        whereArgs: [chatId],
      );

      final List<ChatMessage> messages = messageMaps.map((messageMap) {
        return ChatMessage(
          sentMessage: messageMap['sentMessage'],
          receivedMessage: messageMap['receivedMessage'],
          sentMessageTime: DateTime.parse(messageMap['sentMessageTime']),
          receivedMessageTime: DateTime.parse(messageMap['receivedMessageTime']),
        );
      }).toList();

      chats.add(Chat(
        image: chatMap['imagePath'],
        username: chatMap['username'],
        lastmessage: chatMap['lastMessage'],
        status: chatMap['status'] == 1,
        received: chatMap['received'] == 1,
        read: chatMap['read'] == 1,
        time: DateTime.parse(chatMap['time']),
        lastSeenTime: DateTime.parse(chatMap['lastSeenTime']),
        conversations: messages,
        //mute: chatMap['mute'] == 1,
      ));
    }

    return chats;
  }
}