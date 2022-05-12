import 'package:employees/viewModel/checkin_viewmodel.dart';
import 'package:flutter/material.dart';

class CheckinList extends StatelessWidget {
  final List<CheckinViewModel> checkins;
  CheckinList({required this.checkins});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: checkins.length,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
      itemBuilder: (context, index) {
        final checkinData = checkins[index];
        return ListTile(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => DetailScreen(
            //               eventData: events,
            //             )));
          },
          contentPadding: EdgeInsets.all(10),
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(employeeData.avatar),
          //   radius: 30,
          // ),
          title: Text(
            checkinData.location,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  checkinData.checkindate,
                  style: const TextStyle(color: Colors.black, fontSize: 12.0),
                ),
              ),
              const SizedBox(
                height: 1.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  checkinData.purpose,
                  style: const TextStyle(color: Colors.black, fontSize: 12.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
