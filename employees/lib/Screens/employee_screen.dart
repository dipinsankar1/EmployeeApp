import 'package:employees/Screens/employee_detail.dart';
import 'package:employees/viewModel/employee_list_viewmodel.dart';
import 'package:employees/viewModel/employee_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

List<EmployeeViewModel> paginatedDataSource = [];
EmployeeListViewModel? vm;
const int rowsPerPage = 10;

class _EmployeeScreenState extends State<EmployeeScreen> {
  late EmployeeDataSource _employeeDataSource;
  bool showLoadingIndicator = true;
  double pageCount = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<EmployeeListViewModel>(context, listen: false).getEmployees();
    _employeeDataSource = EmployeeDataSource();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<EmployeeListViewModel>(context);
    pageCount = (vm!.employees.length / rowsPerPage).ceilToDouble();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(children: [
            Column(
              children: [
                SizedBox(
                    height: constraints.maxHeight - 60,
                    width: constraints.maxWidth,
                    child: buildStack(constraints)),
                Container(
                  height: 60,
                  width: constraints.maxWidth,
                  child: SfDataPager(
                    pageCount: 10,
                    direction: Axis.horizontal,
                    onPageNavigationStart: (int pageIndex) {
                      setState(() {
                        showLoadingIndicator = true;
                      });
                    },
                    delegate: _employeeDataSource,
                    onPageNavigationEnd: (int pageIndex) {
                      setState(() {
                        showLoadingIndicator = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ]);
        },
      ),
    );
  }

  Widget buildDataGrid(BoxConstraints constraint) {
    return SfDataGrid(
      source: _employeeDataSource,
      allowSorting: true,
      allowMultiColumnSorting: true,
      sortingGestureType: SortingGestureType.doubleTap,
      columnWidthMode: ColumnWidthMode.fill,
      rowHeight: 50,
      onCellTap: (DataGridCellTapDetails details) {
        final DataGridRow row = _employeeDataSource
            .effectiveRows[details.rowColumnIndex.rowIndex - 1];

        print(details.rowColumnIndex.rowIndex - 1);

        final employeeDetail =
            vm!.employees[details.rowColumnIndex.rowIndex - 1];

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EmployeeDetail(
                  employeeData: employeeDetail,
                )));
      },
      columns: <GridColumn>[
        GridTextColumn(
            columnName: 'id',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text(
                  'Employee ID',
                ))),
        GridTextColumn(
            columnName: 'name',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text('Employee Name'))),
      ],
    );
  }

  Widget buildStack(BoxConstraints constraints) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];
      stackChildren.add(buildDataGrid(constraints));

      if (showLoadingIndicator) {
        stackChildren.add(Container(
          color: Colors.black12,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ));
      }

      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource() {
    //paginatedDataSource = _employees.getRange(1, 10).toList();
    buildDataGridRows();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    await Future.delayed(const Duration(seconds: 3));
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (startIndex < vm!.employees.length) {
      if (endIndex > vm!.employees.length) {
        endIndex = vm!.employees.length;
      }
      paginatedDataSource =
          vm!.employees.getRange(startIndex, endIndex).toList(growable: false);
      buildDataGridRows();
    } else {
      paginatedDataSource = [];
    }
    notifyListeners();
    return true;
  }

  void buildDataGridRows() {
    _employeeData = paginatedDataSource
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
