import 'package:employees/Model/employee_model.dart';

class EmployeeViewModel {
  final EmployeeModel employee;
  EmployeeViewModel({required this.employee});

  String get id {
    return employee.id;
  }

  String get name {
    return employee.name;
  }

  String get email {
    return employee.email;
  }

  String get phone {
    return employee.phone;
  }

  String get avatar {
    return employee.avatar;
  }

  String get country {
    return employee.country;
  }
}
