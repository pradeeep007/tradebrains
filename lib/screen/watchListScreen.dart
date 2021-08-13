import 'package:flutter/material.dart';
import 'package:tradebrains/data/api/api.dart';
import 'package:tradebrains/data/models/SharePriceModel.dart';
import 'package:tradebrains/data/models/watchListedModel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../boxes.dart';
import '../constants.dart';

class WatchListScreen extends StatefulWidget {
  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Watch Lists"),
          centerTitle: true,backgroundColor: kThemeColor,
        ),
        body: ValueListenableBuilder<Box<WatchListHive>>(
          valueListenable: Boxes.getWatchLists().listenable(),
          builder: (context, box, _) {
            final watchList = box.values.toList().cast<WatchListHive>();
            return buildContent(watchList);
          },
        ));
  }
}

Widget buildContent(List<WatchListHive> transactions) {
  if (transactions.isEmpty) {
    return Center(
      child: Text(
        'ADD WatchList!',
        style: TextStyle(fontSize: 24),
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              Row(
                children: [
                  Expanded(child: Text("Company Name",style: kTextStyle,)),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 30),
                 child: Text("Price",style: kTextStyle,),
               ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.delete,color: Colors.grey,),
                  ),
                  Divider(
                    color: Colors.redAccent,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              final transaction = transactions[index];
              return Column(
                children: [
                  Row(
                    children: [
                    Expanded(child: Text("${transactions[index].name}",overflow: TextOverflow.ellipsis,)),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: FutureBuilder<SharePrice>(
                            future: Repository().getSharePrice(transactions[index].symbol),
                            builder: (context, snapShot) {
                              if (snapShot.hasData) {
                                print(snapShot.data!.globalQuote.the05Price);
                                return Text(snapShot.data!.globalQuote.the05Price);
                              } else {
                                return Center(child: SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(color: kThemeColor,strokeWidth: 2,)));
                              }
                            }),
                      ),
                      IconButton(
                          onPressed: () {
                            deleteStock(transactions[index]);
                          },
                          icon: Icon(Icons.delete,color: Colors.red)),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

void deleteStock(WatchListHive stock) {
  stock.delete();
}
