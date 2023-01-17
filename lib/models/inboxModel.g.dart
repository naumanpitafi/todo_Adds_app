// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inboxModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InboxModelAdapter extends TypeAdapter<InboxModel> {
  @override
  final int typeId = 3;

  @override
  InboxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InboxModel(
      todoText: fields[0] as String?,
      dateTime: fields[1] as String?,
      status: fields[2] as String?,
      extendedate: fields[3] as String?,
      trashStatus: fields[4] as String?,
      somedayMaybeStatus: fields[5] as String?,
      referenceStatus: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InboxModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.todoText)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.extendedate)
      ..writeByte(4)
      ..write(obj.trashStatus)
      ..writeByte(5)
      ..write(obj.somedayMaybeStatus)
      ..writeByte(6)
      ..write(obj.referenceStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InboxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
