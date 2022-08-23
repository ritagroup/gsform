class DateDataModel {
  DateTime dateServerType;
  int timeStamp;
  String showDateStr;

  DateDataModel({required this.dateServerType, required this.timeStamp, required this.showDateStr});
}

class DateDataRangeModel {
  DateTime startDateServerType;
  DateTime endDateServerType;
  int startTimeStamp;
  int endTimeStamp;
  String displayStartDateStr;
  String displayEndDateStr;

  DateDataRangeModel(
      {required this.startDateServerType,
      required this.endDateServerType,
      required this.startTimeStamp,
      required this.endTimeStamp,
      required this.displayStartDateStr,
      required this.displayEndDateStr});
}

enum GSDateFormatType {
  numeric, // 1401/04/04
  fullText, //  شنبه 04 تیر 1401
  mediumText, // شنبه 04 تیر
  shortText, // 04 تیر ,1401
}

enum GSCalendarType { jalali, gregorian }

class GSDate {
  int year;

  int month;

  int day;

  GSDate({required this.year, required this.month, required this.day});
}
