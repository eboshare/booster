// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Booster`
  String get appTitle {
    return Intl.message(
      'Booster',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get galleryPageTitle {
    return Intl.message(
      'Images',
      name: 'galleryPageTitle',
      desc: 'Displayed in the app bar of the image list page',
      args: [],
    );
  }

  /// `Can't load an image list`
  String get errorGalleryLoading {
    return Intl.message(
      'Can\'t load an image list',
      name: 'errorGalleryLoading',
      desc: 'Displayed when a loading error occurs on the image list page',
      args: [],
    );
  }

  /// `No connection`
  String get connectionLost {
    return Intl.message(
      'No connection',
      name: 'connectionLost',
      desc: 'Displayed everywhere in the app',
      args: [],
    );
  }

  /// `Back online`
  String get connectionRestored {
    return Intl.message(
      'Back online',
      name: 'connectionRestored',
      desc: 'Displayed everywhere in the app',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}