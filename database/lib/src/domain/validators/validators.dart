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