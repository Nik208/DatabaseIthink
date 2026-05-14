import 'dart:io';
import 'dart:typed_data';

import 'package:database/database.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p1;

class LibraryDatabase{
  final Database _sqlite;

  LibraryDatabase(String filepath):_sqlite= sqlite3.open(filepath){
    _createTables();
  }

  factory LibraryDatabase.inApp(){
    final filepath=p1.join(Directory.current.path,'library.db');
    return LibraryDatabase(filepath);
  }


  void _createTables(){
    _sqlite.execute("""CREATE TABLE IF NOT EXISTS roles(
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL
    );
    """);

    _sqlite.execute("""CREATE TABLE IF NOT EXISTS users(
    id TEXT PRIMARY KEY,
    userName TEXT NOT NULL,
    password TEXT NOT NULL,
    borrowTotal INTEGER NOT NULL,
    role TEXT NOT NULL
    );
    """);

    _sqlite.execute("""CREATE TABLE IF NOT EXISTS books(
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    desc TEXT NOT NULL,
    authorId TEXT NOT NULL,
    rating REAL NOT NULL
    );
    """);

    _sqlite.execute("""CREATE TABLE IF NOT EXISTS authors(
    id TEXT PRIMARY KEY,
    surname TEXT NOT NULL,
    name TEXT NOT NULL,
    copies INTEGER NOT NULL,
    rating REAL NOT NULL
    );
    """);

    _sqlite.execute("""CREATE TABLE IF NOT EXISTS borrow_data(
    id TEXT PRIMARY KEY,
    userId TEXT NOT NULL,
    bookId TEXT NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (bookId) REFERENCES books(id) ON DELETE CASCADE
    );
    """);
  }
  Database get sqlite=>_sqlite;

  void close(){
    _sqlite.dispose();
  }
}










