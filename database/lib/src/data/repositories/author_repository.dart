import 'package:database/database.dart';

class AuthorRepository {
  final LibraryDatabase _db;
  
  AuthorRepository(this._db);
  
  void insertAuthor(Author author) {
    _db.sqlite.execute(
      'INSERT OR REPLACE INTO authors(id,surname,name,rating) VALUES(?,?,?,?)', [
      author.id,
      author.surname,
      author.name,
      author.rating
    ]);
  }
  
  List<Author> getAllAuthors() {
    final rows = _db.sqlite.select('SELECT * FROM authors');
    return rows.map((row) => Author.fromMap(row)).toList();
  }
  
  Author? getAuthorById(String id) {
    final rows = _db.sqlite.select('SELECT * FROM authors WHERE id=?', [id]);
    return rows.isNotEmpty ? Author.fromMap(rows.first) : null;
  }
  
  void updateAuthor(Author author) {
    _db.sqlite.execute(
      'UPDATE authors SET surname=?,name=?,rating=? WHERE id=?', [
      author.surname,
      author.name,
      author.rating,
      author.id
    ]);
  }
  
  void deleteAuthor(String id) {
    _db.sqlite.execute('DELETE FROM authors WHERE id=?', [id]);
  }
}