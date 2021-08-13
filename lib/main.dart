import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tradebrains/screen/homeScreen.dart';
import 'constants.dart';
import 'data/models/watchListedModel.dart';
import 'screen/homeScreen.dart';
import 'screen/watchListScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WatchListHiveAdapter());
  await Hive.openBox<WatchListHive>("watchLists");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'WatchList',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kThemeColor,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        children: <Widget>[HomeScreen(), WatchListScreen()],
        index: _selectedIndex,
      ),
    );
  }
}
