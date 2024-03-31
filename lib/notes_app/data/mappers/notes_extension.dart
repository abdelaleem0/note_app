import 'package:flutter/material.dart';
import 'package:note_app/notes_app/domain/entities/note_entity.dart';
import 'package:note_app/notes_app/database/entities/note.dart';

extension ConvertFromMapToNoteEntitiy on Map<String, dynamic> {
  NoteEntity mapping() {
    return NoteEntity(
        id: this['id'],
        title: this['title'],
        description: this['description'],
        color: this['color'].toString().map());
  }
}
extension ConvertFromNoteToNoteEntity on Note {
  NoteEntity map() {
    return NoteEntity(
        id: id,
        title: title,
        description: description,
        color: color.name.map());
  }
}


extension ConvertFromNoteEntityToNote on NoteEntity {
  Note map() {
    return Note(
        id: id,
        title: title,
        description: description,
        color: color.name.map());
  }
}

extension ConvertFromStringtoEnum on String {
  ColorEnum map() {
    switch (this) {
      case "white":
        return ColorEnum.white;
      case "black":
        return ColorEnum.black;
      case "red":
        return ColorEnum.red;
      case "blue":
        return ColorEnum.blue;
      case "green":
        return ColorEnum.green;
      default:
        return ColorEnum.green;
    }
  }
}

extension GetColor on ColorEnum {
  Color get getColor {
    switch (this) {
      case ColorEnum.white:
        return Colors.black26;
      case ColorEnum.black:
        return Colors.black;

      case ColorEnum.red:
        return Colors.red;

      case ColorEnum.blue:
        return Colors.blue;

      case ColorEnum.green:
        return Colors.green;
    }
  }
}
