import 'package:sqlite3/sqlite3.dart';
import 'package:database/database.dart';


class LibraryRepository{
  final Database _sqlite;
  LibraryRepository(this._sqlite);

  void insertRole(Role role){
      _sqlite.execute('INSERT OR REPLACE INTO roles(id,name) VALUES(?,?)',
      [role.id,
      role.name]);
  }

  void insertUser(User user){
      _sqlite.execute('INSERT OR REPLACE INTO users(id,userName,password,borrowTotal,role) VALUES(?,?,?,?,?)',
      [user.id,
      user.userName,
      user.password,
      user.borrowTotal,
      user.role]);
  }

  void insertBook(Book book){
      _sqlite.execute('INSERT OR REPLACE INTO books(id,title,desc,authorId,rating) VALUES(?,?,?,?,?)',
      [book.id,
      book.title,
      book.desc,
      book.authorId,
      book.rating]);
  }

  void insertAuthor(Author author){
      _sqlite.execute('INSERT OR REPLACE INTO authors(id,surname,name,copies,rating) VALUES(?,?,?,?,?)',
      [author.id,
      author.surname,
      author.name,
      author.copies,
      author.rating]);
  }

  void insertBorrowData(BorrowData borrowData){
      _sqlite.execute('INSERT OR REPLACE INTO borrow_data(id,userId,bookId) VALUES(?,?,?)',
      [borrowData.id,
      borrowData.userId,
      borrowData.bookId]);
  }

  List<Role> getAllRoles(Role role){
    final rows=_sqlite.select('SELECT * FROM roles');
    return rows.map((row)=>Role.fromMap(row)).toList();
  }

  List<User> getAllUsers(User user){
      final rows=_sqlite.select('SELECT * FROM users');
      return rows.map((row)=>User.fromMap(row)).toList();
  }

  List<Book> getAllBooks(Book book){
      final rows=_sqlite.select('SELECT * FROM books');
      return rows.map((row)=>Book.fromMap(row)).toList();
  }

  List<Author> getAllAuthors(Author author){
      final rows=_sqlite.select('SELECT * FROM authors');
      return rows.map((row)=>Author.fromMap(row)).toList();
  }

  List<BorrowData> getAllBorrowData(BorrowData borrowData){
      final rows=_sqlite.select('SELECT * FROM borrow_data');
      return rows.map((row)=>BorrowData.fromMap(row)).toList();
  }

  Role? getRoleById(String id){
  final rows=_sqlite.select('SELECT * FROM roles WHERE id=?',[id]);
  return rows.isNotEmpty ? Role.fromMap(rows.first) : null;
  }

  User? getUserById(String id){
    final rows=_sqlite.select('SELECT * FROM users WHERE id=?',[id]);
    return rows.isNotEmpty ? User.fromMap(rows.first) : null;
  }

  Book? getBookById(String id){
    final rows=_sqlite.select('SELECT * FROM books WHERE id=?',[id]);
    return rows.isNotEmpty ? Book.fromMap(rows.first) : null;
  }

  Author? getAuthorById(String id){
    final rows=_sqlite.select('SELECT * FROM authors WHERE id=?',[id]);
    return rows.isNotEmpty ? Author.fromMap(rows.first) : null;
  }

  BorrowData? getBorrowDataById(String id){
    final rows=_sqlite.select('SELECT * FROM borrow_data WHERE id=?',[id]);
    return rows.isNotEmpty ? BorrowData.fromMap(rows.first) : null;
  }

  void updateRole(Role role){
      _sqlite.execute('UPDATE roles SET name=? WHERE id=?',
      [role.name, role.id]);
  }

  void updateUser(User user){
      _sqlite.execute('UPDATE users SET userName=?,password=?,borrowTotal=?,role=? WHERE id=?',
      [user.userName, user.password, user.borrowTotal, user.role, user.id]);
  }

  void updateBook(Book book){
      _sqlite.execute('UPDATE books SET title=?,desc=?,authorId=?,rating=? WHERE id=?',
      [book.title, book.desc, book.authorId, book.rating, book.id]);
  }

  void updateAuthor(Author author){
      _sqlite.execute('UPDATE authors SET surname=?,name=?,copies=?,rating=? WHERE id=?',
      [author.surname, author.name, author.copies, author.rating, author.id]);
  }

  void updateBorrowData(BorrowData borrowData){
      _sqlite.execute('UPDATE borrow_data SET userId=?,bookId=? WHERE id=?',
      [borrowData.userId, borrowData.bookId, borrowData.id]);
  }

  void deleteRole(String id){
    _sqlite.execute('DELETE FROM roles WHERE id=?',[id]);
  }

  void deleteUser(String id){
      _sqlite.execute('DELETE FROM users WHERE id=?',[id]);
  }

  void deleteBook(String id){
      _sqlite.execute('DELETE FROM books WHERE id=?',[id]);
  }

  void deleteAuthor(String id){
      _sqlite.execute('DELETE FROM authors WHERE id=?',[id]);
  }

  void deleteBorrowData(String id){
      _sqlite.execute('DELETE FROM borrow_data WHERE id=?',[id]);
  }

}