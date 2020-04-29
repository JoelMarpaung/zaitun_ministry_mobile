import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
// import 'package:package_info/package_info.dart';
import 'package:upgrader/upgrader.dart';

import './view/info/index.dart' as info;
import './view/radio/index.dart' as radio;
import './view/schedule/index.dart' as schedule;

void main() => runApp(ZaitunApp());

class ZaitunApp extends StatelessWidget {
  ZaitunApp({
    Key key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();
    final appcastURL =
        'https://raw.githubusercontent.com/JoelMarpaung/AppUpgrader/master/zaitunAppCast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    return MaterialApp(
        title: 'Radio Zaitun',
        home: AudioServiceWidget(
          child: UpgradeAlert(
              appcastConfig: cfg, debugLogging: false, child: HomePage()),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PackageInfo _packageInfo = PackageInfo(
  //   appName: 'Unknown',
  //   packageName: 'Unknown',
  //   version: 'Unknown',
  //   buildNumber: 'Unknown',
  // );

  // @override
  // void initState() {
  //   super.initState();
  //   _initPackageInfo();
  // }

  // Future<void> _initPackageInfo() async {
  //   final PackageInfo info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     _packageInfo = info;
  //   });
  // }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    radio.IndexRadio(),
    schedule.IndexSchedule(),
    info.IndexInfo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // print("test");
    // print(_packageInfo.appName);
    // print(_packageInfo.buildNumber);
    // print(_packageInfo.packageName);
    // print(_packageInfo.version);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        title: Center(
          child: const Text(
            'RADIO ZAITUN',
            style: TextStyle(
              fontFamily: 'Acme',
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
              wordSpacing: 10,
            ),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            title: Text('Radio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Schedule'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Info'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber.shade900,
        onTap: _onItemTapped,
      ),
    );
  }
}
