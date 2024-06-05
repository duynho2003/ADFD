import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/note_item.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final List<String> notes = ['Remember me', 'Buy me', 'Pay me'];
  List<String> searchNotes = ['Remember me', 'Buy me', 'Pay me'];

  final checkedNotes = <String>{};

  var addNoteTextController = TextEditingController();

  var convertNoteToItem = (List<String> notes, Set<String> checkedNotes,
      CheckChangedCallback onCheckChanged) {
    return notes
        .map((note) => NoteListItem(
            note: note,
            isCheck: checkedNotes.contains(note),
            onCheckChanged: onCheckChanged))
        .toList();
  };

  Future showaddNoteDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add new'),
            content: SingleChildScrollView(
                child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  controller: addNoteTextController,
                ),
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    handleCreateNewNote();
                    Navigator.of(context).pop();
                  },
                  child: Text('Create'))
            ],
          );
        });
  }

  void handleCreateNewNote() {
    setState(() {
      var note = addNoteTextController.text;
      if (note != '') {
        notes.add(note);
        searchNotes.add(note);
      }
    });
  }

  void handleSearch(String value) {
    setState(() {
      searchNotes = notes
          .where((note) => note.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void handleCheckedChange(String note, bool isCheck) {
    setState(() {
      if (checkedNotes.contains(note)) {
        checkedNotes.remove(note);
      } else {
        checkedNotes.add(note);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: TextField(
                    onChanged: handleSearch,
                  )),
                  SizedBox(
                    width: 24,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      print('On add note presseed');
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add'),
                  ),
                ],
              ),
            )
          ] +
          convertNoteToItem(searchNotes, checkedNotes, handleCheckedChange),
    );
  }
}
