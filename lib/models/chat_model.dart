class MessageModel{
    String senderId ='';
     String recieverId ='';
     String text ='';
     String dateTime ='';



     MessageModel({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.dateTime,
  
     });

     MessageModel.fromjson(Map<String,dynamic>? json){
      senderId = json!['senderId'];
      recieverId =json['recieverId'];
      text = json['text'];
      dateTime = json['dateTime'];
 

     }

     Map<String,dynamic> toMap(){
      return{
        'senderId':senderId,
        'recieverId':recieverId,
        'text':text,
        'dateTime':dateTime,
    
      };
     }

}