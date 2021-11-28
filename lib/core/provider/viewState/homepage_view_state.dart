
import 'package:flutter/material.dart';
import 'package:smartnote/core/models/homepage.dart';

class HomepgaeViewState with ChangeNotifier {
  HomepageStatus? _statusFilter;
  // int? _warehouseIdFilter;

  HomepageStatus? get statusFilter {
    return _statusFilter;
  }

  void setStatusFilter(HomepageStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

}