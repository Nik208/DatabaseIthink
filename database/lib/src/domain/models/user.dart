import 'identity.dart';

class User implements Identity{
  @override
  final String id;
  final String userName;
  final String password;
  final int borrowTotal;
  final String role;

  User({required this.id, required this.userName, required this.password, required this.borrowTotal, required this.role});

  Map<String,dynamic> toMap() => {
    "id":id,
    "userName":userName,
    "password":password,
    "borrowTotal":borrowTotal,
    "role":role
  };

  factory User.fromMap(Map<String,dynamic> map){
    return User(
      id: map["id"] as String,
      userName: map["userName"] as String,
      password: map["password"] as String,
      borrowTotal: map["borrowTotal"] as int,
      role: map["role"] as String
    );
  }
}