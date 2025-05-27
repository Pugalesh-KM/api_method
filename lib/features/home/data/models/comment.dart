class Comment{
  int? id;
  int? postId;
  String? name;
  String? email;
  String? body;

  Comment({
    this.id,
    this.postId,
    this.name,
    this.email,
    this.body
  });

  Comment.fromJson(Map <String,dynamic> json){
    id =json['id'];
    postId = json['postId'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data ={};
    data['id'] = id;
    data['postId'] = postId ;
    data['name'] =name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }


}