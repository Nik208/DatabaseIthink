import 'package:database/database.dart';
import 'rep_user.dart';

class UserRepositoryImpl implements UserRepository {
  final LibraryDatabase _database;
  
  UserRepositoryImpl(this._database);
  
  @override
  List<User> getAllUsers() {
    return _database.getAllUsers();
  }
  
  @override
  User? getUserById(String id) {
    return _database.getUserById(id);
  }
  
  @override
  void insertUser(User user) {
    _database.insertUser(user);
  }
  
  @override
  void updateUser(User user) {
    _database.updateUser(user);
  }
  
  @override
  void deleteUser(String id) {
    _database.deleteUser(id);
  }
}





