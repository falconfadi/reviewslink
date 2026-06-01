import 'package:flutter/material.dart';
import 'package:reviews_link_v2/l10n/app_localizations.dart';

extension LocalizationExtensions on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
