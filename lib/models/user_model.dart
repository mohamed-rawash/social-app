class UserModel{
  String? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? coverImage;
  String? bio;

  UserModel({this.id, this.name, this.email, this.phone, this.image, this.coverImage, this.bio});

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    coverImage = json['cover_image'];
    bio = json['bio'];
  }

  toJson(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'bio': bio,
      'cover_image': coverImage
    };
  }
}