

import 'package:easy_localization/easy_localization.dart';

import '../configs/charity_configs.dart';

class CharityDateUtils {

  static int timestampFromString(String dateStr) {
    final df = DateFormat(CharityConfig.dateFormat);
    var date = df.parse(dateStr);
    return date.millisecondsSinceEpoch;
  }

  static String formattedDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final df = DateFormat(CharityConfig.dateFormat);
    return df.format(date);
  }

  static int get currentTimestamp {
    DateTime now = DateTime.now();
    return now.millisecondsSinceEpoch;
  }

}