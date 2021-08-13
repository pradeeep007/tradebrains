class SearchData {
  SearchData({
    required this.bestMatches,
  });

  List<BestMatch> bestMatches;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        bestMatches: List<BestMatch>.from(
            json["bestMatches"].map((x) => BestMatch.fromJson(x))),
      );
}

class BestMatch {
  BestMatch({
    required this.the1Symbol,
    required this.the2Name,
    required this.the3Type,
    required this.the4Region,
    required this.the5MarketOpen,
    required this.the6MarketClose,
    required this.the7Timezone,
    required this.the8Currency,
    required this.the9MatchScore,
  });

  String the1Symbol;
  String the2Name;
  String the3Type;
  String the4Region;
  String the5MarketOpen;
  String the6MarketClose;
  String the7Timezone;
  String the8Currency;
  String the9MatchScore;

  factory BestMatch.fromJson(Map<String, dynamic> json) => BestMatch(
        the1Symbol: json["1. symbol"],
        the2Name: json["2. name"],
        the3Type: json["3. type"],
        the4Region: json["4. region"],
        the5MarketOpen: json["5. marketOpen"],
        the6MarketClose: json["6. marketClose"],
        the7Timezone: json["7. timezone"],
        the8Currency: json["8. currency"],
        the9MatchScore: json["9. matchScore"],
      );
}
