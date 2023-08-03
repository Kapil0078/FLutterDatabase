class Note {
  final int? id;
  final String title, contact, desc, date;
  final bool done;

  Note({
    this.id,
    required this.title,
    required this.contact,
    required this.desc,
    required this.date,
    required this.done,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        contact: json["contact"],
        desc: json["desc"],
        date: json["date"],
        done: json["done"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "contact": contact,
        "desc": desc,
        "date": date,
        "done": done ? 1 : 0,
      };
}
