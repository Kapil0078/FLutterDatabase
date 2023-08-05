class Note {
  final int? id;
  final String title, desc;
  final DateTime date;
  final bool done;

  Note({
    this.id,
    required this.title,
    required this.desc,
    required this.date,
    required this.done,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        date: DateTime.parse(json["date"]),
        done: json["done"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "date": date.toIso8601String(),
        "done": done ? 1 : 0,
      };
}
