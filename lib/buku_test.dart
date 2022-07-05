class Buku {

  final int id;
  final String judul;
  final int pengarang_id;
  final String genre;
  DateTime createdAt;
  DateTime updatedAt;

  Buku({
    required this.id,
    required this.judul,
    required this.pengarang_id,
    required this.genre,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json["id"],
      judul: json["judul"],
      pengarang_id: json["pengarang_id"],
      genre: json["genre"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),

    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "pengarang_id": pengarang_id,
    "genre": genre,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  static List<Buku> listFromJson(List<dynamic> list) =>
      List<Buku>.from(list.map((x) => Buku.fromJson(x)));


}