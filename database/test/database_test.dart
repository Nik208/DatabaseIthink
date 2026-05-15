import 'package:test/test.dart';
import 'package:database/database.dart'; 
import 'package:sqlite3/sqlite3.dart';



void main() {
  test('validateRequired - Должен удалить пробелы', () {
    expect(validateRequired('John', 'Name'), equals('John'));
    expect(validateRequired('  John  ', 'Name'), equals('John'));
  });
  
  test('validateRequired - Ошибка при пустом вводе', () {
    expect(() => validateRequired('', 'Name'), throwsException);
    expect(() => validateRequired('   ', 'Name'), throwsException);
  });
  
  test('validatePositiveInt - Должен пропустить положительные числа', () {
    expect(validatePositiveInt(5, 'BorrowTotal'), equals(5));
    expect(validatePositiveInt(100, 'BorrowTotal'), equals(100));
  });
  
  test('validatePositiveInt - Ошибка при <= 0', () {
    expect(() => validatePositiveInt(0, 'BorrowTotal'), throwsException);
    expect(() => validatePositiveInt(-1, 'BorrowTotal'), throwsException);
  });
  
  test('validatePositiveDouble - Должен пропустить целые числа', () {
    expect(validatePositiveDouble(4.5, 'Rating'), equals(4.5));
    expect(validatePositiveDouble(3.0, 'Rating'), equals(3.0));
  });
  
  test('validatePositiveDouble - Ошибка при <= 0', () {
    expect(() => validatePositiveDouble(0, 'Rating'), throwsException);
    expect(() => validatePositiveDouble(-2.5, 'Rating'), throwsException);
  });

  test('toMap и fromMap должны стабильно работать с данными User', () {
      final originalUser = User(
        id: 'u123',
        userName: 'ivanov',
        password: 'pass123',
        borrowTotal: 5,
        role: 'admin'
      );

      final map = originalUser.toMap();
      final copyUser = User.fromMap(map);

      expect(copyUser.id, equals(originalUser.id));
      expect(copyUser.userName, equals(originalUser.userName));
      expect(copyUser.password, equals(originalUser.password));
      expect(copyUser.borrowTotal, equals(originalUser.borrowTotal));
      expect(copyUser.role, equals(originalUser.role));
  });

  test('User fromMap должен поймать и выдать ошибку при вводе неправильных данных', () {
      final invalidMap = {
        'id': 'u123',
        'userName': 'ivanov',
        'password': 'pass123',
        'borrowTotal': '123', 
        'role': 'admin'
      };

      expect(() => User.fromMap(invalidMap), throwsA(isA<TypeError>()));
    });

    group('2. Тест вставки и чтения пользователя из временной SQLite', () {
    late Database db;

    setUp(() {
      db = sqlite3.openInMemory();
      
      db.execute('''
        CREATE TABLE IF NOT EXISTS roles(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL
        )
      ''');
      
      db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id TEXT PRIMARY KEY,
          userName TEXT NOT NULL,
          password TEXT NOT NULL,
          borrowTotal INTEGER NOT NULL,
          role TEXT NOT NULL,
          FOREIGN KEY (role) REFERENCES roles(id) ON DELETE CASCADE
        )
      ''');
      
    });

    tearDown(() {
      db.dispose();
    });

    test('Вставка и чтение пользователя', () {
      db.execute('INSERT INTO roles(id, name) VALUES(?,?)', ['user', 'User']);
      
      db.execute(
        'INSERT INTO users(id, userName, password, borrowTotal, role) VALUES(?,?,?,?,?)',
        ['u1', 'test_user', 'pass123', 3, 'user']
      );
      
      final result = db.select('SELECT * FROM users WHERE id=?', ['u1']);
      
      expect(result.isNotEmpty, true);
      expect(result.first['userName'], 'test_user');
      expect(result.first['borrowTotal'], 3);
    });
    
    test('Обновление пользователя', () {
      db.execute('INSERT INTO roles(id, name) VALUES(?,?)', ['user', 'User']);
      db.execute(
        'INSERT INTO users(id, userName, password, borrowTotal, role) VALUES(?,?,?,?,?)',
        ['u1', 'old_name', 'pass', 0, 'user']
      );
      
      db.execute(
        'UPDATE users SET userName=?, borrowTotal=? WHERE id=?',
        ['new_name', 5, 'u1']
      );
      
      final result = db.select('SELECT * FROM users WHERE id=?', ['u1']);
      
      expect(result.first['userName'], 'new_name');
      expect(result.first['borrowTotal'], 5);
    });
  });
}