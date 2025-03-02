// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatAdapter extends TypeAdapter<Chat> {
  @override
  final int typeId = 2;

  @override
  Chat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chat(
      image: fields[0] as String?,
      username: fields[1] as String?,
      lastmessage: fields[2] as String?,
      status: fields[3] as bool?,
      received: fields[4] as bool?,
      read: fields[5] as bool?,
      time: fields[6] as DateTime?,
      conversations: (fields[7] as List?)?.cast<ChatMessage>(),
      lastSeenTime: fields[8] as DateTime?,
    )..mute = fields[9] as bool;
  }

  @override
  void write(BinaryWriter writer, Chat obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.lastmessage)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.received)
      ..writeByte(5)
      ..write(obj.read)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.conversations)
      ..writeByte(8)
      ..write(obj.lastSeenTime)
      ..writeByte(9)
      ..write(obj.mute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
