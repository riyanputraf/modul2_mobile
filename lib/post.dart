class Post {
  final int userId;
  final int id;
  final String title;
  final String body;


  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json ['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'id' : id,
    'title' : title,
    'body' : body,
  };

  static List<Post> listFromJson(List<dynamic> list) =>
      List<Post>.from(list.map((x) => Post.fromJson(x)));


}