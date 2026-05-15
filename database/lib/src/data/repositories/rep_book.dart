import 'package:database/src/domain/models/book.dart';

abstract class BookRepository {
  List<Book> getAllBooks();
  Book? getBookById(String id);
  void insertBook(Book book);
  void updateBook(Book book);
  void deleteBook(String id);
}