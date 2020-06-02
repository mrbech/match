// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ColorMatch on Color {
  T match<T>(
      {T Function() any,
      T Function() red,
      T Function() green,
      T Function() blue}) {
    final v = this;
    if (v == Color.red && red != null) {
      return red();
    }

    if (v == Color.green && green != null) {
      return green();
    }

    if (v == Color.blue && blue != null) {
      return blue();
    }

    if (any != null) {
      return any();
    }

    throw Exception('Color.match failed, found no match for: $this');
  }
}

extension ExprMatch on Expr {
  T match<T>({T Function() any, T Function(Value) value, T Function(Add) add}) {
    final v = this;
    if (v is Value && value != null) {
      return value(v);
    }

    if (v is Add && add != null) {
      return add(v);
    }

    if (any != null) {
      return any();
    }

    throw Exception('Expr.match failed, found no match for: $this');
  }
}
