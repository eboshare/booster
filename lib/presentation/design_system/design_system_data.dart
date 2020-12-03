import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';

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
    // Const variables are required for DesignSystemData to compile as const.
    const blackColor = Color(0xFF1D1C1F);
    const whiteColor = Color(0xFFFFFFFF);
    const softBlackColor = Color(0xFF3E3C42);
    const blueColor = Colors.blue;

    const colors = DesignSystemColors(
      black: blackColor,
      white: whiteColor,
      softBlack: softBlackColor,
      blue: blueColor,
    );

    return const DesignSystemData(
      colors: colors,
      dimensions: DesignSystemDimensions(
        imageInListSize: 150,
        galleryTileInnerPadding: 10,
        listViewPadding: 15,
        maxInteractiveViewerScale: 5,
      ),
      text: DesignSystemText(
        h1: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 42,
          letterSpacing: 0.02 * 42,
          color: blackColor,
        ),
        h4: TextStyle(
          fontSize: 30,
          letterSpacing: 0.02 * 30,
          color: blackColor,
        ),
        button: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          height: 24 / 18,
          color: softBlackColor,
          letterSpacing: 0.02 * 18,
        ),
      ),
    );
  }
}
