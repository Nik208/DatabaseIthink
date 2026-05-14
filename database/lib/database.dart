import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;

abstract class Id{
  String get id;
}

class Role implements Id{
  @override
  final String id;
  final String name;

  Role({required this.id, required this.name});

  Map<String,dynamic> toMap() => {
    "id":id,
    "name":name
  };

  factory Role.fromMap(Map<String,dynamic> map){
    return Role(
      id: map["id"] as String,
      name: map["name"] as String
    );
  }
}



class User implements Id{
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

class Book implements Id {
  @override
  final String id;
  final String title;
  final String desc;
  final String authorId;
  final double rating;

  Book({required this.id, required this.title, required this.desc, required this.authorId, required this.rating});

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "desc": desc,
    "authorId": authorId,
    "rating": rating
  };

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
    id: map["id"] as String,
    title: map["title"] as String,
    desc: map["desc"] as String,
    authorId: map["authorId"] as String,
    rating: map["rating"] as double
    );
  }
}

class Author implements Id {
  @override
  final String id;
  final String surname;
  final String name;
  final int copies;
  final double rating;

  Author({required this.id, required this.surname, required this.name, required this.copies, required this.rating});

  Map<String, dynamic> toMap() => {
    "id": id,
    "surname": surname,
    "name": name,
    "rating": rating
  };

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: map["id"] as String,
      surname: map["surname"] as String,
      name: map["name"] as String,
      copies: _isInt(map["copies"]),
      rating: _isDouble(map["rating"])
    );
  }
  static int _isInt(Object? v){
        if(v is int) return v.toInt();
        if(v is double) return v.toInt();
        throw FormatException("Ожидалось число", v);
      }
      static double _isDouble(Object? b){
        if(b is double) return b.toDouble();
        if(b is int) return b.toDouble();
        throw FormatException("Ожидалось число", b);
      }
}

class BorrowData implements Id {
  @override
  final String id;
  final String userId;
  final String bookId;

  BorrowData({required this.id, required this.userId, required this.bookId});

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "bookId": bookId
  };

  factory BorrowData.fromMap(Map<String, dynamic> map) {
    return BorrowData(
      id: map["id"] as String,
      userId: map["userId"] as String,
      bookId: map["bookId"] as String
    );
  }
}
