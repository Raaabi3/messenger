import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'RuleModel.g.dart';


@HiveType(typeId: 3)
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

  @HiveField(6)
  bool enableDelay;

  @HiveField(7)
  Duration? delayDuration; // Store the selected delay duration

  @HiveField(8)
  TimeOfDay? conditionTime;

  RuleModel({
    required this.id,
    required this.name,
    required this.conditionType,
    required this.conditionValue,
    required this.actionType,
    this.replyMessage = '',
    this.enableDelay = false,
    this.delayDuration,
    this.conditionTime,
  });

  RuleModel copyWith({
    String? id,
    String? name,
    String? conditionType,
    String? conditionValue,
    String? actionType,
    String? replyMessage,
    bool? enableDelay,
    Duration? delayDuration,
    TimeOfDay? conditionTime,
  }) {
    return RuleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      conditionType: conditionType ?? this.conditionType,
      conditionValue: conditionValue ?? this.conditionValue,
      actionType: actionType ?? this.actionType,
      replyMessage: replyMessage ?? this.replyMessage,
      enableDelay: enableDelay ?? this.enableDelay,
      delayDuration: delayDuration ?? this.delayDuration,
      conditionTime: conditionTime ?? this.conditionTime,
    );
  }
}