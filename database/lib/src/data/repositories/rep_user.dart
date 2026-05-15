import 'package:database/src/domain/models/user.dart';

abstract class UserRepository {
  List<User> getAllUsers();
  User? getUserById(String id);
  void insertUser(User user);
  void updateUser(User user);
  void deleteUser(String id);
}


