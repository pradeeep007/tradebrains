import 'package:hive/hive.dart';
part 'watchListedModel.g.dart';

@HiveType(typeId: 0)
class WatchListHive extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String symbol;
}

class WatchListModel {
  String name;
  String symbol;

  WatchListModel({required this.name, required this.symbol});

  factory WatchListModel.fromJson(Map<String, dynamic> jsonData) {
    return WatchListModel(
      name: jsonData['name'],
      symbol: jsonData['symbol'],
    );
  }

}