import 'package:employees/Widgets/checkinlist.dart';
import 'package:employees/viewModel/employee_list_viewmodel.dart';
import 'package:employees/viewModel/employee_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeDetail extends StatefulWidget {
  static String id = 'EmployeeDetail';
  const EmployeeDetail({required this.employeeData});

  final EmployeeViewModel employeeData;

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  @override
  void initState() {
    Provider.of<EmployeeListViewModel>(context, listen: false)
        .getcheckinById(widget.employeeData.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EmployeeListViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(widget.employeeData.avatar),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.employeeData.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.employeeData.country,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.employeeData.phone,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.employeeData.email,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.blueAccent,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Checkin Details",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: CheckinList(checkins: vm.checkin))
          ],
        ),
      ),
    );
  }
}
