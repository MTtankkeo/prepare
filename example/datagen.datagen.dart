// ignore_for_file: unused_import, unnecessary_question_mark

import 'datagen.dart';
import 'package:datagen/annotation.dart';

/// A class that provides an auto-completion implementation for [A].
class $A {
  const $A(this._a, this._b, this._c);

  final String _a;
  final String _b;
  final String _c;

  /// Returns the value of [A.a] as [String]
  String get a => _a;

  /// Returns the value of [A.b] as [String]
  String get b => _b;

  /// Returns the value of [A.c] as [String]
  String get c => _c;

  /// Returns a new instance of [A] with the given fields replaced.
  /// If a field is not provided, the original value is preserved.
  /// Useful for creating modified copies of immutable objects.
  A copyWith({String? a, String? b, String? c}) {
    return A(a: a ?? _a, b: b ?? _b, c: c ?? _c);
  }

  /// Creates an instance of [A] from a JSON map.
  static A fromJson(Map<String, dynamic> json) {
    return A(
      a: (json['a'] as String),
      b: (json['b'] as String),
      c: (json['c'] as String),
    );
  }

  /// Creates a list of [A] instances from a JSON list.
  static List<A> fromJsonList(List list) {
    return list
        .cast<Map<String, dynamic>>()
        .map((json) => fromJson(json))
        .toList();
  }

  /// Converts this [B] instance into a JSON-compatible map.
  /// Includes all fields of [B] for serialization purposes.
  Map<String, dynamic> toJson() {
    return {'a': _a, 'b': _b, 'c': _c};
  }

  @override
  int get hashCode => Object.hash(_a.hashCode, _b.hashCode, _c.hashCode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is A && other._a == _a && other._b == _b && other._c == _c;
  }

  @override
  String toString() {
    return 'A(a: $_a, b: $_b, c: $_c)';
  }
}
