import 'dart:io';

class RegisterModel {
  String? _email;
  String? _uid;
  String? _image;
  String? _bio;
  String? _name;
  String? _createdAt;
  String? _phone;

  RegisterModel(
      {  
        String? email,
  String? uid,
  String? image,
  String? bio,
  String? name,
  String? createdAt,
  String? phone
      }){
  this._bio = bio;
    this._createdAt = createdAt;
    this._email = email;
    this._image = image;
    this._uid = uid;
    this._name=name;
    this._phone=phone;
   
      }
        String? get  bio => _bio;
  String? get createdAt => _createdAt;
  String? get email => _email;
  String? get image => _image;
  String? get uid => _uid;
  String? get name =>_name;
   String? get phone=>_phone;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    _bio = json['bio'];
    _email = json['email'];
    _name = json['name'];
    _uid = json['uid'];
    _createdAt = json['createdAt'];
    _image = json['image'];
    _phone=json['phone'];
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
  data['bio']=_bio;
  data['email']= _email;
  data['image']=_image;
  data['uid']= _uid;
  data['createdAt']=_createdAt;
  data['phone']=_phone;
  return data;
  }
}
