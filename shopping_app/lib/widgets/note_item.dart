import 'package:flutter/material.dart';

typedef CheckChangedCallback = Function(String note, bool isCheck);

class NoteListItem extends StatelessWidget {
  const NoteListItem(
      {super.key,
      required this.note,
      required this.isCheck,
      required this.onCheckChanged});

  final String note;
  final bool isCheck;
  final CheckChangedCallback onCheckChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      tristate: true,
      value: isCheck,
      title: Text(note),
      onChanged: (value) => onCheckChanged(note, value ?? isCheck),
    );
  }
}
