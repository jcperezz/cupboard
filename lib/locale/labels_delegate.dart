import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/locale/labels.dart';

class LabelsDelegate extends LocalizationsDelegate<Labels> {
  const LabelsDelegate();

  @override
  bool isSupported(Locale locale) =>
      Labels.languages().contains(locale.languageCode);

  @override
  Future<Labels> load(Locale locale) {
    return SynchronousFuture<Labels>(Labels(locale));
  }

  @override
  bool shouldReload(LabelsDelegate old) => false;
}
