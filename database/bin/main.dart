import 'package:database/database.dart';
import 'package:database/src/data/repositories/role_repository.dart';
import 'package:database/src/data/repositories/user_repository.dart';
import 'package:database/src/data/repositories/author_repository.dart';
import 'package:database/src/data/repositories/book_repository.dart';
import 'package:database/src/data/repositories/borrow_repository.dart';

void main(List<String> arguments) {
  final db = LibraryDatabase.inApp();

  final roleRepo = RoleRepository(db);
  final userRepo = UserRepository(db);
  final authorRepo = AuthorRepository(db);
  final bookRepo = BookRepository(db);
  final borrowRepo = BorrowRepository(db);

  try {
    runMenu(roleRepo, userRepo, authorRepo, bookRepo, borrowRepo);
  } finally {
    db.close();
  }
}
