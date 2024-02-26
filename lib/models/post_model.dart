class PostModel {
  String name = '';
  String uId = '';
  String image = '';
  String postImage = '';
  String dateTime = '';
  String text = '';
  int? likes;
  int? comments;
  bool isLikedByMe = false;

  PostModel(
      {required this.name,
      required this.uId,
      required this.postImage,
      required this.image,
      required this.dateTime,
      required this.text,
      required this.comments,
      required this.likes,
      required this.isLikedByMe});

  PostModel.fromjson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
    likes = json['likes'];
    comments = json['comments'];
    isLikedByMe = json['isLikedByMe'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,
      'comments': comments,
      'likes': likes,
      'isLikedByMe':isLikedByMe
    };
  }
}

class CommentModel {
  String name = '';
  String uId = '';
  String userImage = '';
  String commentImage = '';
  String comment = '';
  String dateTime = '';

  CommentModel(
      {required this.name,
      required this.uId,
      required this.comment,
      required this.userImage,
      required this.dateTime,
      required this.commentImage});

  CommentModel.fromjson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    userImage = json['image'];
    comment = json['comment'];
    dateTime = json['dateTime'];
    commentImage = json['commentImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': userImage,
      'comment': comment,
      'dateTime': dateTime,
      'commentImage': commentImage
    };
  }
}

class LikeModel {
  String name = '';
  String uId = '';
  String userImage = '';
  String dateTime = '';

  LikeModel({
    required this.name,
    required this.uId,
    required this.userImage,
    required this.dateTime,
  });

  LikeModel.fromjson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    userImage = json['image'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': userImage,
      'dateTime': dateTime,
    };
  }
}
