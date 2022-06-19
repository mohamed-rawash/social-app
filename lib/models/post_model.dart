class PostModel{
  String? id;
  String? postId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({this.id, this.postId, this.name, this.image, this.dateTime, this.text, this.postImage});

  PostModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    postId = json['post_id'];
    name = json['name'];
    image = json['image'];
    dateTime = json['date_time'];
    text = json['text'];
    postImage = json['post_image'];
  }

  toJson(){
    return {
      'id': id,
      'post_id': postId,
      'name': name,
      'date_time': dateTime,
      'image': image,
      'text': text,
      'post_image': postImage
    };
  }
}