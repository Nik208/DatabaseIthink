import 'package:database/database.dart';

class UserRepository {
  final LibraryDatabase _db;
  
  UserRepository(this._db);
  
  void insertUser(User user) {
    _db.sqlite.execute(
      'INSERT OR REPLACE INTO users(id,userName,password,borrowTotal,role) VALUES(?,?,?,?,?)', [
      user.id,
      user.userName,
      user.password,
      user.borrowTotal,
      user.role
    ]);
  }
  
  List<User> getAllUsers() {
    final rows = _db.sqlite.select('SELECT * FROM users');
    return rows.map((row) => User.fromMap(row)).toList();
  }
  
  User? getUserById(String id) {
    final rows = _db.sqlite.select('SELECT * FROM users WHERE id=?', [id]);
    return rows.isNotEmpty ? User.fromMap(rows.first) : null;
  }
  
  void updateUser(User user) {
    _db.sqlite.execute(
      'UPDATE users SET userName=?,password=?,borrowTotal=?,role=? WHERE id=?', [
      user.userName,
      user.password,
      user.borrowTotal,
      user.role,
      user.id
    ]);
  }
  
  void deleteUser(String id) {
    _db.sqlite.execute('DELETE FROM users WHERE id=?', [id]);
  }
}