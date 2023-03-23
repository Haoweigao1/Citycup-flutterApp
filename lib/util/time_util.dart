

///日期转时间戳
int dateToTimestamp(String date, {isMicroseconds = false}) {
  DateTime dateTime = DateTime.parse(date);
  int timestamp = dateTime.millisecondsSinceEpoch;
  if (isMicroseconds) {
    timestamp = dateTime.microsecondsSinceEpoch;
  }
  return timestamp;
}



DateTime timestampToDate(int timestamp) {
  DateTime dateTime = DateTime.now();

  ///如果是十三位时间戳返回这个
  if (timestamp.toString().length == 13) {
    dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  } else if (timestamp.toString().length == 16) {
  ///如果是十六位时间戳
  dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
  }
  return dateTime;

}


///时间戳转日期
///[timestamp] 时间戳
///[onlyNeedDate ] 是否只显示日期 舍去时间
String timestampToDateStr(int timestamp, {onlyNeedDate = false}) {
  DateTime dataTime = timestampToDate(timestamp);
  String dateTime = dataTime.toString();

  ///去掉时间后面的.000
  dateTime = dateTime.substring(0, dateTime.length - 4);
  if (onlyNeedDate) {
    List<String> dataList = dateTime.split(" ");
    dateTime = dataList[0];
  }
  return dateTime;
}


DateTime _changeTimeDate(time) {
  ///如果传进来的是字符串 13/16位 而且不包含-
  DateTime dateTime = DateTime.now();
  if (time is String) {
  if ((time.length == 13 || time.length == 16) && !time.contains("-")) {
    dateTime = timestampToDate(int.parse(time));
  } else {
    dateTime = DateTime.parse(time);
   }
  } else if (time is int) {
    dateTime = timestampToDate(time);
  }
  return dateTime;
}


///判断日期是不是在这个期间
///[startData] 开始时间 格式可以是 字符串或者时间戳
/// [endData] 结束时间 格式可以是 字符串或者时间戳
///[days] 间隔几天,可以不传入结束时间依靠间隔天数来判断是否在期限内
bool checkDateDuring({required startData, endData, days = 1}) {
  if (startData.toString().isEmpty) {
    return false;
  }

  ///当前时间
  DateTime nowDate = DateTime.now();

  ///开始时间
  DateTime startDate = _changeTimeDate(startData);

  ///结束时间
  DateTime endDate = endData.toString().isNotEmpty
  ? _changeTimeDate(endData)
      : startDate.add(Duration(days: days));

  ///如果在开始时间以后结束时间以前
  return nowDate.isAfter(startDate) && nowDate.isBefore(endDate);
}


///检测时间距离当前是今天 昨天 前天还是某个日期 跨年显示 年-月-日 不跨年显示 月-日
String getDateScope({required checkDate}) {
  String temp = DateTime.now().toString();
  List listTemp = temp.split(" ");
  temp = listTemp[0];
  DateTime nowTime = DateTime.parse(temp);
  DateTime checkTime = _changeTimeDate(checkDate);

  Duration diff = checkTime.difference(nowTime);

  ///如果不同年 返回 年-月-日 小时:分钟 不显示秒及其.000
  if (checkTime.year != nowTime.year) {
    return checkTime.toString().substring(0, checkTime.toString().length - 7);
  }

  /// 同年判断是不是前天/昨天/今天/
  if ((diff < const Duration(hours: 24)) &&
  (diff > const Duration(hours: 0))) {
    return "今天 ${_dataNum(checkTime.hour)}:${_dataNum(checkTime.minute)}";
  } else if ((diff < const Duration(hours: 0)) &&
  (diff > const Duration(hours: -24))) {
    return "昨天 ${_dataNum(checkTime.hour)}:${_dataNum(checkTime.minute)}";
  } else if (diff < const Duration(hours: -24) &&
  diff > const Duration(hours: -48)) {
    return "前天 ${_dataNum(checkTime.hour)}:${_dataNum(checkTime.minute)}";
  }

  ///如果剩下都不是就返回 月-日 然后时间
  return checkTime.toString().substring(5, checkTime.toString().length - 7);
}

String _dataNum(numb) {
  if (numb < 10) {
    return "0$numb";
  }
  return numb.toString();
}