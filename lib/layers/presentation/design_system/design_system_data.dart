import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/utils/extensions.dart';

part 'design_system_data.freezed.dart';

@freezed
abstract class DesignSystemColors with _$DesignSystemColors {
  const factory DesignSystemColors({
    @required Color white,
    @required Color black,
    @required Color softBlack,
    @required Color blue,
  }) = _DesignSystemColors;
}

@freezed
abstract class DesignSystemText with _$DesignSystemText {
  const factory DesignSystemText({
    @required TextStyle button,
    @required TextStyle h1,
    @required TextStyle h4,
  }) = _DesignSystemText;
}

@freezed
abstract class DesignSystemDimensions with _$DesignSystemDimensions {
  const factory DesignSystemDimensions({
    @required double imageInListSize,
    @required double listViewPadding,
    @required double imageListTileInnerPadding,
    @required double maxInteractiveViewerScale,
  }) = _DesignSystemDimensions;
}

class DesignSystemData {
  final DesignSystemColors colors;
  final DesignSystemText text;
  final DesignSystemDimensions dimensions;

  const DesignSystemData({
    @required this.colors,
    @required this.text,
    @required this.dimensions,
  });

  factory DesignSystemData.main() {
    final color = DesignSystemColors(
      black: '#1D1C1F'.toColor(),
      white: '#FFFFFF'.toColor(),
      softBlack: '#3E3C42'.toColor(),
      blue: Colors.blue,
    );

    return DesignSystemData(
      colors: color,
      dimensions: const DesignSystemDimensions(
        imageInListSize: 150,
        imageListTileInnerPadding: 10,
        listViewPadding: 15,
        maxInteractiveViewerScale: 5,
      ),
      text: DesignSystemText(
        h1: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 42,
          letterSpacing: 0.02 * 42,
          color: color.black,
        ),
        h4: TextStyle(
          fontSize: 30,
          letterSpacing: 0.02 * 30,
          color: color.black,
        ),
        button: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          height: 24 / 18,
          color: color.softBlack,
          letterSpacing: 0.02 * 18,
        ),
      ),
    );
  }
}
