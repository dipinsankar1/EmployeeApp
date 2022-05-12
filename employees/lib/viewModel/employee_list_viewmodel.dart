import 'package:employees/WebService/apimanager.dart';
import 'package:employees/viewModel/employee_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'checkin_viewmodel.dart';

class EmployeeListViewModel extends ChangeNotifier {
  List<EmployeeViewModel> employees = [];
  List<CheckinViewModel> checkin = [];

  Future<void> getEmployees() async {
    final results = await ApiModel().fetchEmployees();
    employees =
        results.map((item) => EmployeeViewModel(employee: item)).toList();
    notifyListeners();
  }

  Future<void> getcheckinById(String id) async {
    final results = await ApiModel().fetchCheckins(id);
    checkin = results.map((item) => CheckinViewModel(checkins: item)).toList();
    notifyListeners();
  }
}
