import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/standalone.dart' as standalone;
import 'package:timezone/timezone.dart';
import 'timezone_list_screen.dart';
void main() async {
  var byteData = await rootBundle.load('packages/timezone/data/2019b.tzf');
  initializeDatabase(byteData.buffer.asUint8List());
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  Location currentLocation;

  HomeScreen({this.currentLocation});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map map;
  @override
  void initState() {
    print('hey');
    setup();
    // TODO: implement initState
    super.initState();
  }

  Future<void> setup() async {
    map = standalone.timeZoneDatabase.locations;
    print(standalone.timeZoneDatabase.locations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 46.0, right: 8, top: 64, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Select time zone',
                    style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left: 30.0, right: 8, top: 24, bottom: 0),
              child: ListTile(
                onTap: () {
                  print('hey');
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                  return  TimeZoneListScreen(timezones: map,) ;
                 }));
                },
                title: Text(
                  'Region',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                subtitle: Text(widget.currentLocation==null?
                  'Asia/Calcutta':'${widget.currentLocation}',
                  style: TextStyle(color: Color(0xFF7D7D7D),fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
