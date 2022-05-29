/// returns an double from the given value.
///
/// Used because the backend might return an int when a double value is a whole number.
double getDouble(dynamic jsonNumberValue, {bool nullIsOk = true}) {
  if (jsonNumberValue is double) return jsonNumberValue;
  if (jsonNumberValue is String) return double.parse(jsonNumberValue);
  if (nullIsOk && jsonNumberValue == null) return null;
  // ignore: avoid_dynamic_calls
  return jsonNumberValue.toDouble();
}
