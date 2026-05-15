import 'package:database/database.dart';

void main(List<String> arguments) {
  final db = LibraryDatabase.inApp();
  try {
    runMenu(db);
  } finally {
    db.close();
  }
}
