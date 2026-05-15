import 'package:database/database.dart';
import 'rep_book.dart';

class BookRepositoryImpl implements BookRepository {
  final LibraryDatabase _database;
  
  BookRepositoryImpl(this._database);
  
  @override
  List<Book> getAllBooks() {
    return _database.getAllBooks();
  }
  
  @override
  Book? getBookById(String id) {
    return _database.getBookById(id);
  }
  
  @override
  void insertBook(Book book) {
    _database.insertBook(book);
  }
  
  @override
  void updateBook(Book book) {
    _database.updateBook(book);
  }
  
  @override
  void deleteBook(String id) {
    _database.deleteBook(id);
  }
}
