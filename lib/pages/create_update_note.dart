// ignore_for_file: use_build_context_synchronously

import 'package:database_flutter/component/loading_component.dart';
import 'package:database_flutter/component/my_text_form_field.dart';
import 'package:database_flutter/constant.dart';
import 'package:database_flutter/helper/date_format.dart';
import 'package:database_flutter/helper/get_date.dart';
import 'package:database_flutter/note_class.dart';
import 'package:database_flutter/note_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateUpdateNote extends StatefulWidget {
  final int? noteID;
  const CreateUpdateNote({super.key, this.noteID});

  @override
  State<CreateUpdateNote> createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends State<CreateUpdateNote> {
  // database
  final database = NoteDatabase.instance;
  // variables
  final _formKey = GlobalKey<FormState>();
  bool isDone = false;
  DateTime? doneDate;
  bool btnLoading = false;
  bool isLoading = false;

  // controller
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    if (widget.noteID != null) {
      _getSingleNote();
    }
    super.initState();
  }

  Future<void> _getSingleNote() async {
    setState(() => isLoading = true);

    final note = await database.singleNote(widget.noteID!);
    titleController.text = note?.title ?? "";
    descController.text = note?.desc ?? "";
    dateController.text = note?.date != null ? formatWithYear(note!.date) : "";
    doneDate = note?.date;
    isDone = note?.done ?? false;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create TODO"),
      ),
      floatingActionButton: ActionChip(
        label: btnLoading ? const LoadingComponent() : const Text("Save"),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        avatar: const Icon(
          Icons.save,
          color: Colors.black,
        ),
        onPressed: () async {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            final note = Note(
              title: titleController.text.trim(),
              desc: descController.text.trim(),
              date: doneDate!,
              done: isDone,
            );

            setState(() => btnLoading = true);
            await database.createNote(note);
            setState(() => btnLoading = false);

            Navigator.pop(
              context,
            );
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFormField(
                  controller: titleController,
                  label: "Title",
                  hintText: "Enter title",
                  validator: (title) {
                    if (title != null && title.trim().isNotEmpty) return null;
                    return "Please enter title";
                  },
                ),
                fieldHeight,
                MyTextFormField(
                  controller: descController,
                  label: "Description",
                  hintText: "Enter description",
                  maxLines: 6,
                  validator: (desc) {
                    if (desc != null && desc.trim().isNotEmpty) return null;
                    return "Please enter description";
                  },
                ),
                fieldHeight,
                MyTextFormField(
                  controller: dateController,
                  label: "Date",
                  absorbing: true,
                  hintText: "Select date",
                  validator: (date) {
                    if (date != null && date.trim().isNotEmpty) return null;
                    return "Please select date";
                  },
                  onTap: () async {
                    final date = await getDate(
                      context: context,
                      initialDate: doneDate,
                    );

                    if (date != null) {
                      setState(() {
                        doneDate = date;
                        dateController.text = formatWithYear(date);
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Is Done ?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          activeColor: primary,
                          value: isDone,
                          onChanged: (_) => setState(() => isDone = _),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
