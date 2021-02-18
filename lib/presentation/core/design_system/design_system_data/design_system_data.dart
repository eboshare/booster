import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:booster/presentation/core/design_system/design_system_colors/design_system_colors.dart';
import 'package:booster/presentation/core/design_system/design_system_text/design_system_text.dart';
import 'package:booster/presentation/core/design_system/design_system_dimensions/design_system_dimensions.dart';

part 'design_system_data.freezed.dart';

@freezed
abstract class DesignSystemData with _$DesignSystemData {
  const factory DesignSystemData({
    @required DesignSystemColors colors,
    @required DesignSystemText text,
    @required DesignSystemDimensions dimensions,
  }) = _DesignSystemData;

  factory DesignSystemData.main() {
    // Const variables are required for DesignSystemData to compile as const.
    const blackColor = Color(0xFF1D1C1F);
    const whiteColor = Color(0xFFFFFFFF);
    const softBlackColor = Color(0xFF3E3C42);
    const blueColor = Colors.blue;
    const greenColor = Colors.green;

    const colors = DesignSystemColors(
      black: blackColor,
      white: whiteColor,
      softBlack: softBlackColor,
      blue: blueColor,
      green: greenColor,
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
