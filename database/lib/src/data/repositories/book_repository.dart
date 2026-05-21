import 'package:database/database.dart';

class BookRepository {
  final LibraryDatabase _db;
  
  BookRepository(this._db);
  
  void insertBook(Book book) {
    _db.sqlite.execute(
      'INSERT OR REPLACE INTO books(id,title,desc,authorId,copies,rating) VALUES(?,?,?,?,?,?)', [
      book.id,
      book.title,
      book.desc,
      book.authorId,
      book.copies,
      book.rating
    ]);
  }
  
  List<Book> getAllBooks() {
    final rows = _db.sqlite.select('SELECT * FROM books');
    return rows.map((row) => Book.fromMap(row)).toList();
  }
  
  Book? getBookById(String id) {
    final rows = _db.sqlite.select('SELECT * FROM books WHERE id=?', [id]);
    return rows.isNotEmpty ? Book.fromMap(rows.first) : null;
  }
  
  void updateBook(Book book) {
    _db.sqlite.execute(
      'UPDATE books SET title=?,desc=?,authorId=?,copies=?,rating=? WHERE id=?', [
      book.title,
      book.desc,
      book.authorId,
      book.copies,
      book.rating,
      book.id
    ]);
  }
  
  void deleteBook(String id) {
    _db.sqlite.execute('DELETE FROM books WHERE id=?', [id]);
  }
}