const kBaseUrl = 'https://holiday.ecotechkh.com/api';

class Suggestion {
  String? title;
  String? icon;
  Suggestion({this.title, this.icon});
}

class LearningLevel {
  double value, maxValue;
  String title;
  LearningLevel(
      {required this.value, required this.maxValue, required this.title});
}
