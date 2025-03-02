// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RuleModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RuleModelAdapter extends TypeAdapter<RuleModel> {
  @override
  final int typeId = 3;

  @override
  RuleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RuleModel(
      id: fields[0] as String,
      name: fields[1] as String,
      conditionType: fields[2] as String,
      conditionValue: fields[3] as String,
      actionType: fields[4] as String,
      replyMessage: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RuleModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.conditionType)
      ..writeByte(3)
      ..write(obj.conditionValue)
      ..writeByte(4)
      ..write(obj.actionType)
      ..writeByte(5)
      ..write(obj.replyMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
