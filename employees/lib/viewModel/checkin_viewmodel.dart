import 'package:employees/Model/checkin_model.dart';
import 'package:employees/WebService/apimanager.dart';
import 'package:intl/intl.dart';

class CheckinViewModel {
  final CheckinModel checkins;
  CheckinViewModel({required this.checkins});

  String get id {
    return checkins.id;
  }

  String get location {
    return checkins.location;
  }

  String get purpose {
    return checkins.purpose;
  }

  String get checkindate {
    final DateFormat formatter = DateFormat('EEE, dd MMM yyyy hh:mm aaa');
    final String formattedDate = formatter.format(checkins.checkin);
    return formattedDate;
  }
}
