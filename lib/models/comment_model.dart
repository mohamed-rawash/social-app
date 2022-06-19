class Comment {
  String? uId;
  String? uName;
  String? uImage;
  String? postId;
  String? commentId;
  String? commentText;

  Comment({required this.uId, required this.postId, required this.commentId, required this.commentText, required this.uName, required this.uImage});

  Comment.fromJson(Map<String, dynamic> json) {
    uId = json['uid'];
    uName = json['user_name'];
    uImage = json['user_image'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    commentText = json['comment_text'];
  }
  toJson(){
    return {
      "uid": uId,
      "user_name": uName,
      "user_image": uImage,
      "post_id": postId,
      "comment_id": commentId,
      "comment_text": commentText,
    };
  }
}
