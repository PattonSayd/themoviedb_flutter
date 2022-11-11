import 'package:flutter/material.dart';

class LocalizedStorage {
  String _localeTag = '';

  String get localeTag => _localeTag;

  bool updateData(Locale locale) {
    final localeTag = locale.toLanguageTag();
    if (_localeTag == localeTag) return false;
    _localeTag = localeTag;
    return true;
  }
}
