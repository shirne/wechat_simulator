import 'dart:convert';

abstract class Model {
  Map<String, dynamic> toJson();

  @override
  String toString() => jsonEncode(toJson);
}
