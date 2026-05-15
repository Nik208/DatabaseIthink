import 'identity.dart';

class Author implements Identity {
  @override
  final String id;
  final String surname;
  final String name;
  final double rating;

  Author({required this.id, required this.surname, required this.name, required this.rating});

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
      rating: _isDouble(map["rating"])
    );
  }
  static double _isDouble(Object? b){
        if(b is double) return b.toDouble();
        if(b is int) return b.toDouble();
        throw FormatException("Ожидалось число", b);
      }
}