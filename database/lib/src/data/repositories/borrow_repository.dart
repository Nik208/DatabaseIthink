import 'package:database/database.dart';

class BorrowRepository {
  final LibraryDatabase _db;
  
  BorrowRepository(this._db);
  
  void insertBorrowData(BorrowData borrowData) {
    _db.sqlite.execute(
      'INSERT OR REPLACE INTO borrow_data(id,userId,bookId) VALUES(?,?,?)', [
      borrowData.id,
      borrowData.userId,
      borrowData.bookId
    ]);
  }
  
  List<BorrowData> getAllBorrowData() {
    final rows = _db.sqlite.select('SELECT * FROM borrow_data');
    return rows.map((row) => BorrowData.fromMap(row)).toList();
  }
  
  BorrowData? getBorrowDataById(String id) {
    final rows = _db.sqlite.select('SELECT * FROM borrow_data WHERE id=?', [id]);
    return rows.isNotEmpty ? BorrowData.fromMap(rows.first) : null;
  }
  
  void updateBorrowData(BorrowData borrowData) {
    _db.sqlite.execute(
      'UPDATE borrow_data SET userId=?,bookId=? WHERE id=?', [
      borrowData.userId,
      borrowData.bookId,
      borrowData.id
    ]);
  }
  
  void deleteBorrowData(String id) {
    _db.sqlite.execute('DELETE FROM borrow_data WHERE id=?', [id]);
  }
}