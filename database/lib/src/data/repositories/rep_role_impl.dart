import 'package:database/database.dart';
import 'rep_role.dart';

class RoleRepositoryImpl implements RoleRepository {
  final LibraryDatabase _database;
  
  RoleRepositoryImpl(this._database);
  
  @override
  List<Role> getAllRoles() {
    return _database.getAllRoles();
  }
  
  @override
  Role? getRoleById(String id) {
    return _database.getRoleById(id);
  }
  
  @override
  void insertRole(Role role) {
    _database.insertRole(role);
  }
  
  @override
  void updateRole(Role role) {
    _database.updateRole(role);
  }
  
  @override
  void deleteRole(String id) {
    _database.deleteRole(id);
  }
}


