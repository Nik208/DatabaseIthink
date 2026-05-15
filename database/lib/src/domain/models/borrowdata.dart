import 'identity.dart';


class BorrowData implements Identity {
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