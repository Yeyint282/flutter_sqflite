String todayDate(){
  DateTime now = DateTime.now();
  String nowDate = now.toString().split(' ')[0];
  return nowDate;
}