// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Spot Memo';

  @override
  String get fetchMemosFailed => 'Something went wrong!\nPull to refresh.';

  @override
  String get fetchMemosEmptyList => 'Nothing to show!\nPull to refresh.';

  @override
  String memoMissingItem(String name) {
    return 'Please add $name!';
  }

  @override
  String get memoMissingItemTitle => 'title';

  @override
  String get memoMissingItemDesc => 'description';

  @override
  String get memoMissingItemImage => 'image';

  @override
  String get addImage => 'Add image';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get save => 'Save';

  @override
  String get location => 'Location';

  @override
  String get selectLocation => 'Select a location';

  @override
  String get youDeniedLocation =>
      'You have permanently denied location permission!';

  @override
  String get select => 'Select';
}
