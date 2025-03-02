import 'package:hive/hive.dart';

part 'RuleModel.g.dart';

@HiveType(typeId: 3) // Ensure unique typeID
class RuleModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String conditionType;

  @HiveField(3)
  String conditionValue;

  @HiveField(4)
  String actionType;

  @HiveField(5)
  String replyMessage;

  RuleModel({
    required this.id,
    required this.name,
    required this.conditionType,
    required this.conditionValue,
    required this.actionType,
    this.replyMessage = '',
  });
}