class CreateSocialUser{
    String name ='';
     String email ='';
     String phone ='';
     String uId ='';
     String image ='';
     String cover ='';
     String bio ='';
    late bool isEmailVerfied;


     CreateSocialUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.isEmailVerfied,
    required this.image,
    required this.cover,
    required this.bio
     });

     CreateSocialUser.fromjson(Map<String,dynamic>? json){
      name = json!['name'];
      email =json['email'];
      phone = json['phone'];
      uId = json['uId'];
      image = json['image'];
      cover = json['cover'];
      bio = json['bio'];
      isEmailVerfied = json['isEmailVerfied'];

     }

     Map<String,dynamic> toMap(){
      return{
        'name':name,
        'email':email,
        'phone':phone,
        'uId':uId,
        'image':image,
        'cover':cover,
        'bio':bio,
        'isEmailVerfied':isEmailVerfied
      };
     }

}