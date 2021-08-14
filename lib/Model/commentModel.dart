
class CommentModel{
  String username;
  String comments;

  CommentModel(
    this.username,
    this.comments,
  );
   @override
  String toString() {
    return toJson().toString();
  }

  CommentModel.fromJson(Map<String, dynamic> json){
    if(json == null) return;
    username = json['username'];
    comments = json['comments'];
  }

  Map<String,dynamic> toJson() {
    Map<String,dynamic> json = {};
    if(username != null) json['username'] = username;
    if(comments != null) json['comments'] = comments;
    return json;
  }

  static List<CommentModel> listFromJson(List<dynamic> json) {
    return json == null
    ? List<CommentModel>()
    :json.map((value) => CommentModel.fromJson(value)).toList();
  }

}



