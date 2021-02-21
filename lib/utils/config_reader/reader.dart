import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:booster/utils/config_reader/config/config.dart';

Future<Config> loadConfig(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);
  final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
  return Config.fromJson(jsonMap);
}
