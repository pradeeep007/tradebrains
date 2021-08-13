import 'package:hive/hive.dart';
import 'data/models/watchListedModel.dart';

class Boxes {
  static Box<WatchListHive> getWatchLists() =>
      Hive.box<WatchListHive>("watchLists");
}
