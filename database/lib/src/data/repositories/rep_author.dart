import 'package:database/src/domain/models/author.dart';

abstract class AuthorRepository {
  List<Author> getAllAuthors();
  Author? getAuthorById(String id);
  void insertAuthor(Author author);
  void updateAuthor(Author author);
  void deleteAuthor(String id);
}

