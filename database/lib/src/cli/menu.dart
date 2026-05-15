import 'dart:io';

import '../data/library_database.dart';
import '../domain/role.dart';
import '../domain/user.dart';
import '../domain/author.dart';
import '../domain/book.dart';
import '../domain/borrowdata.dart';


void runMenu(LibraryDatabase db) {
  while (true) {
    stdout.writeln('''
--- Библиотека Книгоедов ---
1 — список ролей
2 — добавить роль
3 — удалить роль по id
4 — список пользователей
5 — добавить пользователя
6 — удалить пользователя по id
7 — список книг
8 — добавить книгу
9 — удалить книгу по id
10 — список авторов
11 — добавить автора
12 — удалить автора по id
13 — список выдач
14 — добавить выдачу
15 — удалить выдачу по id
16 — Все из БД
0 — выход
Выберите пункт:''');

    final choice = stdin.readLineSync()?.trim() ?? '';
    switch (choice) {
      case '1':
        _printRoles(db);
        break;
      case '2':
        _addRole(db);
        break;
      case '3':
        _deleteRole(db);
        break;
      case '4':
        _printUsers(db);
        break;
      case '5':
        _addUser(db);
        break;
      case '6':
        _deleteUser(db);
        break;
      case '7':
        _printBooks(db);
        break;
      case '8':
        _addBook(db);
        break;
      case '9':
        _deleteBook(db);
        break;
      case '10':
        _printAuthors(db);
        break;
      case '11':
        _addAuthor(db);
        break;
      case '12':
        _deleteAuthor(db);
        break;
      case '13':
        _printBorrowData(db);
        break;
      case '14':
        _addBorrowData(db);
        break;
      case '15':
        _deleteBorrowData(db);
        break;
      case '16':
        _printAllFromDb(db);
        break;
      case '0':
        stdout.writeln('До свидания.');
        return;
      default:
        stdout.writeln('Неизвестная команда.');
    }
    stdout.writeln();
  }
}

void _printRoles(LibraryDatabase db) {
  final list = db.getAllRoles(Role(id: '', name: ''));
  if (list.isEmpty) {
    stdout.writeln('Ролей нет.');
    return;
  }
  for (final r in list) {
    stdout.writeln('id: ${r.id} | ${r.name}');
  }
}

void _printUsers(LibraryDatabase db) {
  final list = db.getAllUsers(User(id: '', userName: '', password: '', borrowTotal: 0, role: ''));
  if (list.isEmpty) {
    stdout.writeln('Пользователей нет.');
    return;
  }
  for (final u in list) {
    stdout.writeln('id: ${u.id} | ${u.userName} | книг: ${u.borrowTotal} | роль: ${u.role}');
  }
}

void _printBooks(LibraryDatabase db) {
  final list = db.getAllBooks(Book(id: '', title: '', desc: '', authorId: '', copies: 0,  rating: 0));
  if (list.isEmpty) {
    stdout.writeln('Книг нет.');
    return;
  }
  for (final b in list) {
    stdout.writeln('id: ${b.id} | ${b.title} | копий: ${b.copies} | рейтинг: ${b.rating}');
  }
}

void _printAuthors(LibraryDatabase db) {
  final list = db.getAllAuthors(Author(id: '', surname: '', name: '', rating: 0));
  if (list.isEmpty) {
    stdout.writeln('Авторов нет.');
    return;
  }
  for (final a in list) {
    stdout.writeln('id: ${a.id} | ${a.name} ${a.surname} | рейтинг: ${a.rating}');
  }
}

void _printBorrowData(LibraryDatabase db) {
  final list = db.getAllBorrowData(BorrowData(id: '', userId: '', bookId: ''));
  if (list.isEmpty) {
    stdout.writeln('Выдач нет.');
    return;
  }
  for (final b in list) {
    stdout.writeln('id: ${b.id} | userId: ${b.userId} | bookId: ${b.bookId}');
  }
}

void _printAllFromDb(LibraryDatabase db) {
  stdout.writeln('------- Роли -------');
  _printRoles(db);
  stdout.writeln('------- Пользователи -------');
  _printUsers(db);
  stdout.writeln('------- Книги -------');
  _printBooks(db);
  stdout.writeln('------- Авторы -------');
  _printAuthors(db);
  stdout.writeln('------- Выдачи -------');
  _printBorrowData(db);
}

void _addRole(LibraryDatabase db) {
  final id = _read('id роли: ');
  final name = _read('название: ');

  validateRequired(name, 'Название');
  db.insertRole(Role(id: id, name: name));
  stdout.writeln('Роль сохранена.');
}

void _deleteRole(LibraryDatabase db) {
  final id = _read('id роли для удаления: ');
  db.deleteRole(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addUser(LibraryDatabase db) {
  final id = _read('id пользователя: ');
  final userName = _read('имя пользователя: ');
  final password = _read('пароль: ');
  final borrowTotal = int.parse(_read('количество книг: '));
  final role = _read('роль: ');

  validateRequired(userName, 'Имя пользователя');
  validateRequired(password, 'Пароль');
  validatePositiveInt(borrowTotal, 'Количество книг');
  validateRequired(role, 'Роль');

  db.insertUser(User(id: id, userName: userName, password: password, borrowTotal: borrowTotal, role: role));
  stdout.writeln('Пользователь сохранён.');
}

void _deleteUser(LibraryDatabase db) {
  final id = _read('id пользователя для удаления: ');
  db.deleteUser(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addBook(LibraryDatabase db) {
  final id = _read('id книги: ');
  final title = _read('название: ');
  final desc = _read('описание: ');
  final authorId = _read('id автора: ');
  final copies = int.parse(_read('количество копий: '));
  final rating = double.parse(_read('рейтинг: ').replaceAll(',', '.'));

  validateRequired(title, 'Название');
  validateRequired(desc, 'Описание');
  validateRequired(authorId, 'ID автора');
  validatePositiveInt(copies, 'Количество копий');
  validatePositiveDouble(rating, 'Рейтинг');

  db.insertBook(Book(id: id, title: title, desc: desc, authorId: authorId, copies: copies,  rating: rating));
  stdout.writeln('Книга сохранена.');
}

void _deleteBook(LibraryDatabase db) {
  final id = _read('id книги для удаления: ');
  db.deleteBook(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addAuthor(LibraryDatabase db) {
  final id = _read('id автора: ');
  final surname = _read('фамилия: ');
  final name = _read('имя: ');
  final rating = double.parse(_read('рейтинг: ').replaceAll(',', '.'));

  validateRequired(surname, 'Фамилия');
  validateRequired(name, 'Имя');
  validatePositiveDouble(rating, 'Рейтинг');

  db.insertAuthor(Author(id: id, surname: surname, name: name, rating: rating));
  stdout.writeln('Автор сохранён.');
}

void _deleteAuthor(LibraryDatabase db) {
  final id = _read('id автора для удаления: ');
  db.deleteAuthor(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addBorrowData(LibraryDatabase db) {
  final id = _read('id выдачи: ');
  final userId = _read('id пользователя: ');
  final bookId = _read('id книги: ');

  validateRequired(userId, 'ID пользователя');
  validateRequired(bookId, 'ID книги');

  db.insertBorrowData(BorrowData(id: id, userId: userId, bookId: bookId));
  stdout.writeln('Выдача сохранена.');
}

void _deleteBorrowData(LibraryDatabase db) {
  final id = _read('id выдачи для удаления: ');
  db.deleteBorrowData(id);
  stdout.writeln('Готово (если id был в базе).');
}

String _read(String label) {
  stdout.write(label);
  return stdin.readLineSync()?.trim() ?? '';
}

String validateRequired(String value, String fieldName) {
  if (value.trim().isEmpty) {
    throw Exception('$fieldName не может быть пустым');
  }
  return value.trim();
}

int validatePositiveInt(int value, String fieldName) {
  if (value <= 0) {
    throw Exception('$fieldName должно быть больше 0');
  }
  return value;
}

double validatePositiveDouble(double value, String fieldName) {
  if (value <= 0) {
    throw Exception('$fieldName должно быть больше 0');
  }
  return value;
}