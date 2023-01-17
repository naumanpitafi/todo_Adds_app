// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleteModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeleteModelAdapter extends TypeAdapter<DeleteModel> {
  @override
  final int typeId = 2;

  @override
  DeleteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeleteModel(
      catgName: fields[0] as String?,
      todotext: fields[1] as String?,
      dateTime: fields[2] as String?,
      todoName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeleteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.catgName)
      ..writeByte(1)
      ..write(obj.todotext)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.todoName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
