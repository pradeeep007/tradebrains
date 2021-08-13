import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tradebrains/data/models/SearchDataModel.dart';
import 'package:tradebrains/data/api/api.dart';
import 'package:tradebrains/data/models/watchListedModel.dart';
import '../boxes.dart';
import "package:tradebrains/constants.dart";



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  Future<void> _refreshLocalGallery() async {
    print('refreshing stocks..start');
    await new Future.delayed(const Duration(seconds: 3));
    print('refreshing stocks...end');
  }

  late Future<SearchData> _searchData;
  String searchString = "";

  Future addTransaction(String name, String symbol) async {
    print("adding $name");
    final watchList = WatchListHive()
      ..name = name
      ..symbol = symbol;

    final box = Boxes.getWatchLists();
    box.add(watchList);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trade Brains"), centerTitle: true,backgroundColor: kThemeColor,),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    cursorColor: kThemeColor,
                    onChanged: (string) {
                      setState(() {
                        searchString = string;
                      });
                    },
                    decoration: kTextFieldDecoration,

                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(
                    //   ),
                    //
                    //   hintText: 'Serach Company',
                    // ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Builder(
                  builder: (context) {
                    if (searchString != "") {
                      return FutureBuilder<SearchData>(
                          future: Repository().getSearchData(searchString),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.bestMatches.length == 0) {
                                return Center(child: Text("No Data Found"));
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data!.bestMatches.length,
                                  itemBuilder: (context, item) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    "${snapshot.data!.bestMatches[item].the2Name}",overflow: TextOverflow.ellipsis,),
                                              ),
                                              IconButton(
                                                  onPressed: (){
                                                    addTransaction(snapshot
                                                        .data!
                                                        .bestMatches[item]
                                                        .the2Name,snapshot
                                                        .data!
                                                        .bestMatches[item]
                                                        .the1Symbol);
                                                  },
                                                  icon: Icon(Icons.add),color: Colors.blueAccent,)
                                            ],
                                          )),
                                    );
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(color: kThemeColor,),
                              );
                            }
                          });
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
