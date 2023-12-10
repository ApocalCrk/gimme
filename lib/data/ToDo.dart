class ToDo {
  final int id_todo, id_user;
  final String nama_todo;
  DateTime? created_at, updated_at;

  ToDo({
    required this.id_todo,
    required this.id_user,
    required this.nama_todo,
    this.created_at,
    this.updated_at
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id_todo: json['id_todo'],
      id_user: json['id_user'],
      nama_todo: json['nama_todo'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_todo': id_todo.toString(),
      'id_user': id_user.toString(),
      'nama_todo': nama_todo.toString(),
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString()
    };
  }
}