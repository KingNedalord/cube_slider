List<Post> listFromJson(dynamic json){
  return List<Post>.from(json.map((e)=> Post.fromJson(e))).toList();
}

class Post{
  int? userId;
  int? id;
  String? title;
  String? body;

  Post(this.userId, this.id, this.title, this.body);


  Post.fromJson(dynamic json){
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
    body = json["body"];
  }
}