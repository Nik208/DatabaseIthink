import 'package:database/database.dart';

class RoleRepository {
  final LibraryDatabase _db;
  
  RoleRepository(this._db);
  
  void insertRole(Role role) {
    _db.sqlite.execute('INSERT OR REPLACE INTO roles(id,name) VALUES(?,?)', [
      role.id,
      role.name
    ]);
  }
  
  List<Role> getAllRoles() {
    final rows = _db.sqlite.select('SELECT * FROM roles');
    return rows.map((row) => Role.fromMap(row)).toList();
  }
  
  Role? getRoleById(String id) {
    final rows = _db.sqlite.select('SELECT * FROM roles WHERE id=?', [id]);
    return rows.isNotEmpty ? Role.fromMap(rows.first) : null;
  }
  
  void updateRole(Role role) {
    _db.sqlite.execute('UPDATE roles SET name=? WHERE id=?', [
      role.name, 
      role.id
    ]);
  }
  
  void deleteRole(String id) {
    _db.sqlite.execute('DELETE FROM roles WHERE id=?', [id]);
  }
}