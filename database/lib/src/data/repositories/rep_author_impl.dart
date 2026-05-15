import 'package:database/database.dart';
import 'rep_author.dart';


class AuthorRepositoryImpl implements AuthorRepository {
  final LibraryDatabase _database;
  
  AuthorRepositoryImpl(this._database);
  
  @override
  List<Author> getAllAuthors() {
    return _database.getAllAuthors();
  }
  
  @override
  Author? getAuthorById(String id) {
    return _database.getAuthorById(id);
  }
  
  @override
  void insertAuthor(Author author) {
    _database.insertAuthor(author);
  }
  
  @override
  void updateAuthor(Author author) {
    _database.updateAuthor(author);
  }
  
  @override
  void deleteAuthor(String id) {
    _database.deleteAuthor(id);
  }

}


