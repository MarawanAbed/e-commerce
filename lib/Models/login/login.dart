class LoginModel
{
  bool? status;
  String? message;
  DataModel? dataModel;


   LoginModel.fromJson(Map<String, dynamic> json) {
    status=json['status'];
    message=json['message'];
    dataModel=json['data']!=null? DataModel.fromJson(json['data']):null;//cuz if therer is any error it will return null
   }
}

class DataModel
{
   int? id;
   String? name;
   String? email;
   String? phone;
   String? image;
   int? points;
   int? credit;
   String? token;

   DataModel.fromJson(Map<String, dynamic> json) {
      id= json["id"];
      name= json["name"];
      email= json["email"];
      phone= json["phone"];
      image= json["image"];
      points= json["points"];
      credit= json["credit"];
      token= json["token"];
  }
//
}