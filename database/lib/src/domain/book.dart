import 'identity.dart';

class Book implements Identity {
  @override
  final String id;
  final String title;
  final String desc;
  final String authorId;
  final int copies; 
  final double rating;

  Book({required this.id, required this.title, required this.desc, required this.authorId, required this.copies, required this.rating});

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "desc": desc,
    "authorId": authorId,
    "copies": copies,
    "rating": rating
  };

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
    id: map["id"] as String,
    title: map["title"] as String,
    desc: map["desc"] as String,
    authorId: map["authorId"] as String,
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