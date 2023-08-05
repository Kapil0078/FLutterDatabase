import 'package:database_flutter/component/loading_component.dart';
import 'package:database_flutter/constant.dart';
import 'package:database_flutter/helper/date_format.dart';
import 'package:database_flutter/note_database.dart';
import 'package:flutter/material.dart';

import '../note_class.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final database = NoteDatabase.instance;
  List<Note> notes = [];
  bool isLoading = false;

  @override
  void initState() {
    _getNote();
    super.initState();
  }

  void _getNote() async {
    setState(() => isLoading = true);
    notes = await database.readNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: isLoading
          ? const Center(child: LoadingComponent(radius: 15))
          : Padding(
              padding: padding,
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes.elementAt(index);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                        ),
                        Text(note.desc),
                        Text(
                          formateWithMMMM(note.date),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
