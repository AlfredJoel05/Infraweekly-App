import 'package:intl/intl.dart';

String jwtToken = 'Bearer ';

void createJwt(raw) {
  jwtToken += raw;
}

String getJwt() {
  return jwtToken;
}

bool isLoggedIn = false;

void setIsLoggedIn(bool status) {
  isLoggedIn = status;
}

bool getIsLoggedIn() {
  return isLoggedIn;
}

DateTime date = DateTime.now();
DateFormat formatter = DateFormat('yyyy-MM-dd');

String getPreviousDate() {
  var prevMonth = DateTime(date.year, date.month - 1, date.day);
  String formatted = formatter.format(prevMonth);
  return formatted;
}

String getCurrentDate() {
  var currDate = DateTime(date.year, date.month, date.day);
  String formatted = formatter.format(currDate);
  return formatted;
}
