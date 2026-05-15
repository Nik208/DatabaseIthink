import 'package:database/src/domain/models/role.dart';

abstract class RoleRepository {
  List<Role> getAllRoles();
  Role? getRoleById(String id);
  void insertRole(Role role);
  void updateRole(Role role);
  void deleteRole(String id);
}
