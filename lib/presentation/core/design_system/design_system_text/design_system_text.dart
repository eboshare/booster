import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'design_system_text.freezed.dart';

@freezed
abstract class DesignSystemText with _$DesignSystemText {
  const factory DesignSystemText({
    @required TextStyle button,
    @required TextStyle h1,
    @required TextStyle h4,
  }) = _DesignSystemText;
}
