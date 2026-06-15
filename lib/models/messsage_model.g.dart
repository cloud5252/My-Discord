// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messsage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 1;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      chatRoomId: fields[0] as String?,
      senderId: fields[1] as String?,
      senderEmail: fields[2] as String?,
      receiverId: fields[3] as String?,
      messageText: fields[4] as String?,
      timestamp: fields[5] as DateTime?,
      isRead: (fields[6] as num?)?.toInt(),
      isVoiceMessage: fields[7] as bool?,
      profileUrl: fields[8] as String?,
      firebaseId: fields[9] as String?,
      isPending: fields[10] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.chatRoomId)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.senderEmail)
      ..writeByte(3)
      ..write(obj.receiverId)
      ..writeByte(4)
      ..write(obj.messageText)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.isRead)
      ..writeByte(7)
      ..write(obj.isVoiceMessage)
      ..writeByte(8)
      ..write(obj.profileUrl)
      ..writeByte(9)
      ..write(obj.firebaseId)
      ..writeByte(10)
      ..write(obj.isPending);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
