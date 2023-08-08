import 'package:database_flutter/component/loading_component.dart';
import 'package:database_flutter/constant.dart';
import 'package:database_flutter/helper/date_format.dart';
import 'package:database_flutter/note_database.dart';
import 'package:database_flutter/pages/create_update_note.dart';
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

  Future<void> _getNote() async {
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
      floatingActionButton: ActionChip(
        label: const Text("Create New"),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        avatar: const Icon(
          Icons.note,
          color: Colors.black,
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateUpdateNote(),
            ),
          );

          _getNote();
        },
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              note.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      // maxHeight: 30,
                                      // maxWidth: 30,
                                      ),
                                  child: IconButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateUpdateNote(noteID: note.id),
                                        ),
                                      );

                                      _getNote();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(),
                                  child: IconButton(
                                    onPressed: () async {
                                      await database.deleteNote(note.id!);
                                      _getNote();


                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 18,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Text(
                          note.desc,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          formateWithMMMM(note.date),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 25,
                          decoration: BoxDecoration(
                            color: note.done
                                ? Colors.greenAccent
                                : Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              note.done ? "Completed" : "Pending",
                            ),
                          ),
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
