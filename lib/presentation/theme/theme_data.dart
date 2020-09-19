import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:flutter_starter_template/extensions/extensions.dart';

class ThmColor {
  final Color white;
  final Color black;
  final Color softBlack;

  const ThmColor({
    @required this.white,
    @required this.black,
    @required this.softBlack,
  });
}

class ThmTextStyle {
  final TextStyle button;
  final TextStyle h1;
  final TextStyle h4;

  const ThmTextStyle({
    @required this.button,
    @required this.h1,
    @required this.h4,
  });
}

class ThmData {
  final ThmColor color;
  final ThmTextStyle textTheme;

  const ThmData({
    @required this.color,
    @required this.textTheme,
  });

  factory ThmData.main() {
    final color = ThmColor(
      black: '#1D1C1F'.toColor(),
      white: '#FFFFFF'.toColor(),
      softBlack: '#3E3C42'.toColor(),
    );

    return ThmData(
      color: color,
      textTheme: ThmTextStyle(
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
