String contestId(String contestTypeNumber) {
  int currentHour = DateTime.now().hour;
  String hour;
  if (currentHour > 20 || currentHour < 9) {
    hour = 08.toString();
  } else {
    hour = currentHour.toString();
  }
  if (int.parse(hour) < 10) {
    hour = '0${hour}';
  }
  return '${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${contestTypeNumber}${hour.toString()}';
}

String contestTypeNumber(
  String gameType,
) {
  if (gameType == 'Silver') {
    return '4';
  } else if (gameType == 'Gold') {
    return '3';
  } else if (gameType == 'Platinum') {
    return '4';
  } else {
    return '2';
  }
}
