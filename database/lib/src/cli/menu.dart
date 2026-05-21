// lib/src/cli/menu.dart
import 'dart:io';
import 'input_helper.dart';
import 'package:database/src/data/repositories/role_repository.dart';
import 'package:database/src/data/repositories/user_repository.dart';
import 'package:database/src/data/repositories/author_repository.dart';
import 'package:database/src/data/repositories/book_repository.dart';
import 'package:database/src/data/repositories/borrow_repository.dart';
import 'package:database/src/domain/models/role.dart';
import 'package:database/src/domain/models/user.dart';
import 'package:database/src/domain/models/author.dart';
import 'package:database/src/domain/models/book.dart';
import 'package:database/src/domain/models/borrowdata.dart';

void runMenu(
  RoleRepository roleRepo,
  UserRepository userRepo,
  AuthorRepository authorRepo,
  BookRepository bookRepo,
  BorrowRepository borrowRepo,
) {
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
        _printRoles(roleRepo);
        break;
      case '2':
        _addRole(roleRepo);
        break;
      case '3':
        _deleteRole(roleRepo);
        break;
      case '4':
        _printUsers(userRepo);
        break;
      case '5':
        _addUser(userRepo);
        break;
      case '6':
        _deleteUser(userRepo);
        break;
      case '7':
        _printBooks(bookRepo);
        break;
      case '8':
        _addBook(bookRepo, authorRepo);
        break;
      case '9':
        _deleteBook(bookRepo);
        break;
      case '10':
        _printAuthors(authorRepo);
        break;
      case '11':
        _addAuthor(authorRepo);
        break;
      case '12':
        _deleteAuthor(authorRepo);
        break;
      case '13':
        _printBorrowData(borrowRepo);
        break;
      case '14':
        _addBorrowData(borrowRepo, userRepo, bookRepo);
        break;
      case '15':
        _deleteBorrowData(borrowRepo);
        break;
      case '16':
        _printAllFromDb(roleRepo, userRepo, authorRepo, bookRepo, borrowRepo);
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

void _printRoles(RoleRepository roleRepo) {
  final list = roleRepo.getAllRoles();
  if (list.isEmpty) {
    stdout.writeln('Ролей нет.');
    return;
  }
  for (final r in list) {
    stdout.writeln('id: ${r.id} | ${r.name}');
  }
}

void _printUsers(UserRepository userRepo) {
  final list = userRepo.getAllUsers();
  if (list.isEmpty) {
    stdout.writeln('Пользователей нет.');
    return;
  }
  for (final u in list) {
    stdout.writeln('id: ${u.id} | ${u.userName} | книг: ${u.borrowTotal} | роль: ${u.role}');
  }
}

void _printBooks(BookRepository bookRepo) {
  final list = bookRepo.getAllBooks();
  if (list.isEmpty) {
    stdout.writeln('Книг нет.');
    return;
  }
  for (final b in list) {
    stdout.writeln('id: ${b.id} | ${b.title} | копий: ${b.copies} | рейтинг: ${b.rating}');
  }
}

void _printAuthors(AuthorRepository authorRepo) {
  final list = authorRepo.getAllAuthors();
  if (list.isEmpty) {
    stdout.writeln('Авторов нет.');
    return;
  }
  for (final a in list) {
    stdout.writeln('id: ${a.id} | ${a.name} ${a.surname} | рейтинг: ${a.rating}');
  }
}

void _printBorrowData(BorrowRepository borrowRepo) {
  final list = borrowRepo.getAllBorrowData();
  if (list.isEmpty) {
    stdout.writeln('Выдач нет.');
    return;
  }
  for (final b in list) {
    stdout.writeln('id: ${b.id} | userId: ${b.userId} | bookId: ${b.bookId}');
  }
}

void _printAllFromDb(
  RoleRepository roleRepo,
  UserRepository userRepo,
  AuthorRepository authorRepo,
  BookRepository bookRepo,
  BorrowRepository borrowRepo,
) {
  stdout.writeln('------- Роли -------');
  _printRoles(roleRepo);
  stdout.writeln('------- Пользователи -------');
  _printUsers(userRepo);
  stdout.writeln('------- Книги -------');
  _printBooks(bookRepo);
  stdout.writeln('------- Авторы -------');
  _printAuthors(authorRepo);
  stdout.writeln('------- Выдачи -------');
  _printBorrowData(borrowRepo);
}

void _addRole(RoleRepository roleRepo) {
  final id = readId('роли');
  final name = readRequiredString('название: ', 'Название');
  roleRepo.insertRole(Role(id: id, name: name));
  stdout.writeln('Роль сохранена.');
}

void _deleteRole(RoleRepository roleRepo) {
  final id = readId('роли для удаления');
  roleRepo.deleteRole(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addUser(UserRepository userRepo) {
  final id = readId('пользователя');
  final userName = readRequiredString('имя пользователя: ', 'Имя пользователя');
  final password = readRequiredString('пароль: ', 'Пароль');
  final borrowTotal = readBorrowTotal('количество книг: ');
  final role = readRequiredString('роль: ', 'Роль');

  userRepo.insertUser(User(
    id: id,
    userName: userName,
    password: password,
    borrowTotal: borrowTotal,
    role: role,
  ));
  stdout.writeln('Пользователь сохранён.');
}

void _deleteUser(UserRepository userRepo) {
  final id = readId('пользователя для удаления');
  userRepo.deleteUser(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addBook(BookRepository bookRepo, AuthorRepository authorRepo) {
  final id = readId('книги');
  final title = readRequiredString('название: ', 'Название');
  final desc = readRequiredString('описание: ', 'Описание');
  final authorId = readRequiredString('id автора: ', 'ID автора');
  final copies = readPositiveInt('количество копий: ', 'Количество копий');
  final rating = readRating('рейтинг: ');

  final author = authorRepo.getAuthorById(authorId);
  if (author == null) {
    stdout.writeln('Автор с id $authorId не найден');
    return;
  }

  bookRepo.insertBook(Book(
    id: id,
    title: title,
    desc: desc,
    authorId: authorId,
    copies: copies,
    rating: rating,
  ));
  stdout.writeln('Книга сохранена.');
}

void _deleteBook(BookRepository bookRepo) {
  final id = readId('книги для удаления');
  bookRepo.deleteBook(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addAuthor(AuthorRepository authorRepo) {
  final id = readId('автора');
  final surname = readRequiredString('фамилия: ', 'Фамилия');
  final name = readRequiredString('имя: ', 'Имя');
  final rating = readRating('рейтинг: ');

  authorRepo.insertAuthor(Author(
    id: id,
    surname: surname,
    name: name,
    rating: rating,
  ));
  stdout.writeln('Автор сохранён.');
}

void _deleteAuthor(AuthorRepository authorRepo) {
  final id = readId('автора для удаления');
  authorRepo.deleteAuthor(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addBorrowData(
  BorrowRepository borrowRepo,
  UserRepository userRepo,
  BookRepository bookRepo,
) {
  final id = readId('выдачи');
  final userId = readRequiredString('id пользователя: ', 'ID пользователя');
  final bookId = readRequiredString('id книги: ', 'ID книги');

  final user = userRepo.getUserById(userId);
  if (user == null) {
    stdout.writeln('Пользователь с id $userId не найден');
    return;
  }

  final book = bookRepo.getBookById(bookId);
  if (book == null) {
    stdout.writeln('Книга с id $bookId не найдена');
    return;
  }

  if (book.copies <= 0) {
    stdout.writeln('Нет доступных копий книги');
    return;
  }

  borrowRepo.insertBorrowData(BorrowData(
    id: id,
    userId: userId,
    bookId: bookId,
  ));
  stdout.writeln('Выдача сохранена.');
}

void _deleteBorrowData(BorrowRepository borrowRepo) {
  final id = readId('выдачи для удаления');
  borrowRepo.deleteBorrowData(id);
  stdout.writeln('Готово (если id был в базе).');
}