import 'dart:convert';

import 'package:employees/Model/checkin_model.dart';
import 'package:employees/Model/employee_model.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class ApiModel {
  Future<List<EmployeeModel>> fetchEmployees() async {
    var url = "$baseURL/employee";
    //final response = await http.get(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body;
      return json.map((employee) => EmployeeModel.fromJson(employee)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<List<CheckinModel>> fetchCheckins(String id) async {
    var url = "$baseURL/employee/$id/checkin";
    //final response = await http.get(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body;
      return json.map((checkin) => CheckinModel.fromJson(checkin)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
