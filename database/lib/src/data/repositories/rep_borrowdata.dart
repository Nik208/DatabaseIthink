import 'package:database/src/domain/models/borrowdata.dart';

abstract class BorrowDataRepository {
  List<BorrowData> getAllBorrowRecords();
  BorrowData? getBorrowRecordById(String id);
  void insertBorrowRecord(BorrowData borrowData);
  void updateBorrowRecord(BorrowData borrowData);
  void deleteBorrowRecord(String id);
}