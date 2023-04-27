String dateDifference(String? dateInString) {
  List<String> diff = dateInString!.split(",");
  String dateString = diff[0];
  if (dateInString.length > 2) {
    dateString = dateString + diff[1];
  }

  DateTime date = DateTime.parse(dateString);
  if (date == null) {
    return "";
  }
  String difference = 'a';
  DateTime now = DateTime.now();
  int dif = now.difference(date).inSeconds;

  if (dif < 60) {
    difference = dif.toString() + " second ago";
  } else if (dif < 3600) {
    difference = now.difference(date).inMinutes.toString() + " minutes ago";
  } else if (dif < 86400) {
    difference = now.difference(date).inHours.toString() + " hours ago";
  } else if (dif > 86400) {
    int _days = now.difference(date).inDays;

    if (_days <= 1) {
      difference = _days.toString() + " day ago";
    } else if (_days > 1 && _days < 30) {
      difference = _days.toString() + " days ago";
    }
    // else {
    //   difference = (_days ~/ 31).toString() + " months ago";
    // }
    else if (_days >= 30 && _days < 60) {
      difference = (_days / 30).round().toString() + " month ago";
    } else if (_days < 365) {
      difference = (_days / 30).round().toString() + " months ago";
    } else if (_days >= 365 && _days < 730) {
      // int year = now.difference(date).m;
      difference = (_days / 365).round().toString() + " year ago";
    } else if (_days > 730) {
      difference = (_days / 365).round().toString() + " years ago";
    }
  } else {
    difference = '---';
  }

  return difference;
}
