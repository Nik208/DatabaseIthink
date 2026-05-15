import 'package:database/database.dart';
import 'rep_borrowdata.dart';

class BorrowDataRepositoryImpl implements BorrowDataRepository {
  final LibraryDatabase _database;
  
  BorrowDataRepositoryImpl(this._database);
  
  @override
  List<BorrowData> getAllBorrowRecords() {
    return _database.getAllBorrowData();
  }
  
  @override
  BorrowData? getBorrowRecordById(String id) {
    return _database.getBorrowDataById(id);
  }
  
  @override
  void insertBorrowRecord(BorrowData borrowData) {
    _database.insertBorrowData(borrowData);
  }
  
  @override
  void updateBorrowRecord(BorrowData borrowData) {
    _database.updateBorrowData(borrowData);
  }
  
  @override
  void deleteBorrowRecord(String id) {
    _database.deleteBorrowData(id);
  }
}