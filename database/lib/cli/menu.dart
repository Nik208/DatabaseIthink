import 'package:database/database.dart';
import 'package:database/data/database.dart';
import 'package:database/data/rep_client.dart';
import 'package:sqlite3/sqlite3.dart';
import 'dart:io';


void runMenu(LibraryRepository repo){ //
  while(true){
    stdout.writeln(
      """ Библиотека Книгоедов
      1.Список клиентов
      2.Добавить клиента
      3.Изменить клиента
      4.Удалить клиента
      5.Найти пользователя по ID
      6.Показать все данные БД
      """
    );
    final Choice=stdin.readLineSync()?.trim() ?? '';
    switch(Choice){
      case "1":
        _getAllUsers(repo);
        break;
      case "2":
        _addUser(repo);
        break;
      case "3":
        _updateUser(repo);
        break;
      case "4":
        _deleteUser(repo);
        break;
      case "5":
        _getUserById(repo);
        break;
      case "6":
        _showAllDB(repo);
        break;
    }
  }
}

String _read(String label){
  stdout.write("$label");
  return stdin.readLineSync()?.trim() ?? '';
}

void _addUser(LibraryRepository repo){
  final id=_read('id');
  final userName=_read('userName');
  final password=_read('password');
  final borrowTotal=int.parse(_read('borrowTotal'));
  final role=_read('role');

  validateRequired(userName, 'Имя пользователя');
  validateRequired(password, 'Пароль');
  validatePositiveInt(borrowTotal, 'Количество книг');
  validateRequired(role, 'Роль');

  repo.insertUser(User(id: id, userName: userName, password: password, borrowTotal: borrowTotal, role: role));
}

void _deleteUser(LibraryRepository repo){
  final id=_read('id');
  repo.deleteUser(id);
}

void _updateUser(LibraryRepository repo){
  final id=_read('id');
  final userName=_read('userName');
  final password=_read('password');
  final borrowTotal=int.parse(_read('borrowTotal'));
  final role=_read('role');

  validateRequired(userName, 'Имя пользователя');
  validateRequired(password, 'Пароль');
  validatePositiveInt(borrowTotal, 'Количество книг');
  validateRequired(role, 'Роль');

  repo.updateUser(User(id: id, userName: userName, password: password, borrowTotal: borrowTotal, role: role));
}

void _getUserById(LibraryRepository repo){
  final id=_read('id');
  final user=repo.getUserById(id);
  if(user!=null){
    print('ID: ${user.id}, UserName: ${user.userName}, BorrowTotal: ${user.borrowTotal}, Role: ${user.role}');
  } else {
    print('User not found');
  }
}

void _getAllUsers(LibraryRepository repo){
  final users=repo.getAllUsers(User(id: '', userName: '', password: '', borrowTotal: 0, role: ''));
  for(final user in users){
    print('ID: ${user.id}, UserName: ${user.userName}, BorrowTotal: ${user.borrowTotal}, Role: ${user.role}');
  }
}

void _showAllDB(LibraryRepository repo){
  print('\n=========== роли ===========');
  final roles = repo.getAllRoles(Role(id: '', name: ''));
  for(final role in roles){
    print('ID: ${role.id}, Name: ${role.name}');
  }
  
  print('\n=========== Пользователи ===========');
  final users = repo.getAllUsers(User(id: '', userName: '', password: '', borrowTotal: 0, role: ''));
  for(final user in users){
    print('ID: ${user.id}, UserName: ${user.userName}, BorrowTotal: ${user.borrowTotal}, Role: ${user.role}');
  }
  
  print('\n=========== Книги ===========');
  final books = repo.getAllBooks(Book(id: '', title: '', desc: '', authorId: '', rating: 0));
  for(final book in books){
    print('ID: ${book.id}, Title: ${book.title}, AuthorId: ${book.authorId}, Rating: ${book.rating}');
  }
  
  print('\n=========== Авторыы ===========');
  final authors = repo.getAllAuthors(Author(id: '', surname: '', name: '', copies: 0, rating: 0));
  for(final author in authors){
    print('ID: ${author.id}, Name: ${author.name} ${author.surname}, Copies: ${author.copies}, Rating: ${author.rating}');
  }
  
  print('\n=========== Выдачи книг ===========');
  final borrows = repo.getAllBorrowData(BorrowData(id: '', userId: '', bookId: ''));
  for(final borrow in borrows){
    print('ID: ${borrow.id}, UserId: ${borrow.userId}, BookId: ${borrow.bookId}');
  }
}

String validateRequired(String value, String fieldName){
  if(value.trim().isEmpty){
    throw Exception('$fieldName не может быть пустым');
  }
  return value.trim();
}

int validatePositiveInt(int value, String fieldName){
  if(value <= 0){
    throw Exception('$fieldName должно быть больше 0');
  }
  return value;
}

double validatePositiveDouble(double value, String fieldName){
  if(value <= 0){
    throw Exception('$fieldName должно быть больше 0');
  }
  return value;
}

