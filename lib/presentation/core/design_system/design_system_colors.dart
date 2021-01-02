import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DesignSystemColors extends Equatable {
  final Color white;
  final Color black;
  final Color softBlack;
  final MaterialColor blue;

  const DesignSystemColors({
    @required this.white,
    @required this.black,
    @required this.softBlack,
    @required this.blue,
  });

  @override
  List<Object> get props {
    return [
      white,
      black,
      softBlack,
      blue,
    ];
  }
}
