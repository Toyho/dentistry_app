/// email : "q@q.com"
/// password : "123456"
/// registration date : "2021-11-17 – 16:36"

class UserInfo {
  String? _email;
  String? _password;
  String? _registration_date;

  String? get email => _email;
  String? get password => _password;
  String? get registration_date => _registration_date;

  UserInfo({
      String? email, 
      String? password, 
      String? registration_date}){
    _email = email;
    _password = password;
    _registration_date = registration_date;
}

  UserInfo.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _registration_date = json['registration_date'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    map['registration_date'] = _registration_date;
    return map;
  }

}