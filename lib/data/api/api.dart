import 'package:dio/dio.dart';
import 'package:tradebrains/data/models/SearchDataModel.dart';
import 'package:tradebrains/data/models/SharePriceModel.dart';

class Repository {
  final BASE_URL = "https://www.alphavantage.co/";

  // final API_KEY = "4LTUVZ7SLE0N2CFL";
  final API_KEY = "IL4V83FMY25GEYRW";

  final client = Dio();

  Future<SearchData> getSearchData(String keyWord) async {
    print("get search Data");
    final url =
        '${BASE_URL}query?function=SYMBOL_SEARCH&keywords=$keyWord&apikey=$API_KEY';
    print(url);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      print("search succed");
      return SearchData.fromJson(response.data);
    } else {
      throw "${response.statusCode}";
    }
  }

  Future<SharePrice> getSharePrice(String shareName) async {
    print("sharePrice");
    final url =
        '${BASE_URL}query?function=GLOBAL_QUOTE&symbol=$shareName&apikey=$API_KEY';
    print(url);
    final response = await client.get(url);
    print("got sharePrice of $shareName");
    // print("data ${response.statusCode}"+response.data);
    if (response.statusCode == 200) {
      return SharePrice.fromJson(response.data);
    } else {
      throw "${response.statusCode}";
    }
  }
}
