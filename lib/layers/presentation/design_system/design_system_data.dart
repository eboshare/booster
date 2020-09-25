import 'package:flutter/material.dart';

import 'package:flutter_starter_template/helper/extensions.dart';

class DesignSystemColor {
  final Color white;
  final Color black;
  final Color softBlack;
  final Color blue;

  const DesignSystemColor({
    @required this.white,
    @required this.black,
    @required this.softBlack,
    @required this.blue,
  });
}

class DesignSystemText {
  final TextStyle button;
  final TextStyle h1;
  final TextStyle h4;

  const DesignSystemText({
    @required this.button,
    @required this.h1,
    @required this.h4,
  });
}

class DesignSystemData {
  final DesignSystemColor color;
  final DesignSystemText text;

  const DesignSystemData({
    @required this.color,
    @required this.text,
  });

  factory DesignSystemData.main() {
    final color = DesignSystemColor(
      black: '#1D1C1F'.toColor(),
      white: '#FFFFFF'.toColor(),
      softBlack: '#3E3C42'.toColor(),
      blue: Colors.blue,
    );

    return DesignSystemData(
      color: color,
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
