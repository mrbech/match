// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_generator_test.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ColorMatch on Color {
  T match<T>(
      {required T Function() red,
      required T Function() green,
      required T Function() blue}) {
    final v = this;
    if (v == Color.red) {
      return red();
    }

    if (v == Color.green) {
      return green();
    }

    if (v == Color.blue) {
      return blue();
    }

    throw Exception('Color.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? red,
      T Function()? green,
      T Function()? blue}) {
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

    return any();
  }
}

extension ExprMatch on Expr {
  T match<T>({required T Function(Value) value, required T Function(Add) add}) {
    final v = this;
    if (v is Value) {
      return value(v);
    }

    if (v is Add) {
      return add(v);
    }

    throw Exception('Expr.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function(Value)? value,
      T Function(Add)? add}) {
    final v = this;
    if (v is Value && value != null) {
      return value(v);
    }

    if (v is Add && add != null) {
      return add(v);
    }

    return any();
  }
}
