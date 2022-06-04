import 'package:flutter/cupertino.dart';

import 'database/db.dart';

class FragmentChangeNotifier extends ChangeNotifier {
  AppDb? _appDb;

  void initAppDb(AppDb db) {
    _appDb = db;
  }

  List<DairyData> _fragmentsList = [];
  List<DairyData> get fragmentsList => _fragmentsList;
  String _error = '';
  String get error => _error;
  DairyData? _dairyData;
  DairyData? get dairyData => _dairyData;
  bool _added = false;
  bool get added => _added;
  bool _updated = false;
  bool get updated => _updated;
  bool _deleted = false;
  bool get deleted => _deleted;

  void getFragments() {
    _appDb?.getAllFragments().then((value) {
      _fragmentsList = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      _error = error.toString();
      notifyListeners();
    });
  }

  void getSingleFragment(int id) {
    _appDb?.getFragment(id).then((value) {
      _dairyData = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      _error = error.toString();
      notifyListeners();
    });
  }

  void createFragment(DairyCompanion entity) {
    _appDb?.insertFragment(entity).then((value) {
      _added = value >= 1 ? true : false;
      notifyListeners();
    }).onError((error, stackTrace) {
      _error = error.toString();
      notifyListeners();
    });
  }

  void updateFragment(DairyCompanion entity) {
    _appDb?.updateFragment(entity).then((value) {
      _updated = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      _error = error.toString();
      notifyListeners();
    });
  }

  void deleteFragment(int id) {
    _appDb?.deleteFragment(id).then((value) {
      _deleted = value == 1 ? true : false;
      notifyListeners();
    }).onError((error, stackTrace) {
      _error = error.toString();
      notifyListeners();
    });
  }
}
