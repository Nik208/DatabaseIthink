// lib/src/cli/input_helper.dart
import 'dart:io';

String readString(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync()?.trim() ?? '';
}

String readRequiredString(String prompt, String fieldName) {
  final value = readString(prompt);
  if (value.isEmpty) {
    throw Exception('$fieldName не может быть пустым');
  }
  return value;
}

int readInt(String prompt) {
  while (true) {
    try {
      final input = readString(prompt);
      return int.parse(input);
    } catch (e) {
      stdout.writeln('Ошибка: Введите целое число');
    }
  }
}

int readPositiveInt(String prompt, String fieldName) {
  final value = readInt(prompt);
  if (value <= 0) {
    throw Exception('$fieldName должно быть больше 0');
  }
  return value;
}

double readDouble(String prompt) {
  while (true) {
    try {
      final input = readString(prompt);
      return double.parse(input.replaceAll(',', '.'));
    } catch (e) {
      stdout.writeln('Ошибка: Введите число');
    }
  }
}

double readPositiveDouble(String prompt, String fieldName) {
  final value = readDouble(prompt);
  if (value <= 0) {
    throw Exception('$fieldName должно быть больше 0');
  }
  return value;
}

double readRating(String prompt) {
  while (true) {
    final value = readDouble(prompt);
    if (value >= 0 && value <= 5) {
      return value;
    }
    stdout.writeln('Ошибка: Рейтинг должен быть от 0 до 5');
  }
}

int readBorrowTotal(String prompt) {
  while (true) {
    final value = readInt(prompt);
    if (value >= 0 && value <= 10) {
      return value;
    }
    stdout.writeln('Ошибка: Количество книг должно быть от 0 до 10');
  }
}

String readId(String entityName) {
  return readRequiredString('id $entityName: ', 'ID $entityName');
}

bool readBool(String prompt) {
  while (true) {
    final input = readString('$prompt (д/н): ').toLowerCase();
    if (input == 'д' || input == 'да' || input == 'yes' || input == 'y') {
      return true;
    }
    if (input == 'н' || input == 'нет' || input == 'no' || input == 'n') {
      return false;
    }
    stdout.writeln('Ошибка: Введите д (да) или н (нет)');
  }
}

void pressAnyKeyToContinue() {
  stdout.write('\nНажмите Enter чтобы продолжить...');
  stdin.readLineSync();
}

void clearScreen() {
  if (Platform.isWindows) {
    stdout.write('\x1B[2J\x1B[0f');
  } else {
    stdout.write('\x1B[2J\x1B[3J\x1B[H');
  }
}