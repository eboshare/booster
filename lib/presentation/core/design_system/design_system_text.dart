import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DesignSystemText extends Equatable {
  final TextStyle button;
  final TextStyle h1;
  final TextStyle h4;

  const DesignSystemText({
    @required this.button,
    @required this.h1,
    @required this.h4,
  });

  @override
  List<Object> get props {
    return [
      button,
      h1,
      h4,
    ];
  }
}
