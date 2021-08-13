class SharePrice {
  SharePrice({
    required this.globalQuote,
  });

  GlobalQuote globalQuote;

  factory SharePrice.fromJson(Map<String, dynamic> json) => SharePrice(
        globalQuote: GlobalQuote.fromJson(json["Global Quote"]),
      );
}

class GlobalQuote {
  GlobalQuote({
    required this.the01Symbol,
    required this.the02Open,
    required this.the03High,
    required this.the04Low,
    required this.the05Price,
    required this.the06Volume,
    required this.the07LatestTradingDay,
    required this.the08PreviousClose,
    required this.the09Change,
    required this.the10ChangePercent,
  });

  String the01Symbol;
  String the02Open;
  String the03High;
  String the04Low;
  String the05Price;
  String the06Volume;
  DateTime the07LatestTradingDay;
  String the08PreviousClose;
  String the09Change;
  String the10ChangePercent;

  factory GlobalQuote.fromJson(Map<String, dynamic> json) => GlobalQuote(
        the01Symbol: json["01. symbol"],
        the02Open: json["02. open"],
        the03High: json["03. high"],
        the04Low: json["04. low"],
        the05Price: json["05. price"],
        the06Volume: json["06. volume"],
        the07LatestTradingDay: DateTime.parse(json["07. latest trading day"]),
        the08PreviousClose: json["08. previous close"],
        the09Change: json["09. change"],
        the10ChangePercent: json["10. change percent"],
      );
}
