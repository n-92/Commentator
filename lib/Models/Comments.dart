
class Comments {
  int postId;
  String name;
  String email;
  String body;

  Comments(int id, String name, String email, String body) {
    this.postId = id;
    this.name = name;
    this.email = email;
    this.body =  body;
  }

  Comments.fromJson(Map json)
      : postId = json['postID'],
        name = json['name'],
        email = json['email'],
        body = json['body'];

  Map toJson() {
    return {'postId': postId, 'name': name, 'email': email, 'body':body};
  }
}