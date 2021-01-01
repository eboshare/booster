import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'design_system_colors.freezed.dart';

@freezed
abstract class DesignSystemColors with _$DesignSystemColors {
  const factory DesignSystemColors({
    @required Color white,
    @required Color black,
    @required Color softBlack,
    @required MaterialColor blue,
  }) = _DesignSystemColors;
}
