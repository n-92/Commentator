import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_view/Views/ListView.dart';

void main() => runApp(FetchApp());

class FetchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        canvasColor: Colors.transparent,
      ),
      home: MyHomePage(title: 'Commentator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyListScreen(),
    PlaceholderWidget(Colors.green)
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 100,
          title: Text(widget.title),
          flexibleSpace: Image(
            image: NetworkImage('https://avatars2.githubusercontent.com/u/8834529?s=460&v=4'),
            height: 70,
            alignment: Alignment.bottomRight,
            fit: BoxFit.fitHeight,
          ),
          backgroundColor: Color(0xF4133d51),
        ),
        backgroundColor: Color(0xff607D8B),
        body: _children[_currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff607D8B),
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // if you take this out, it won't refresh
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home,color: Colors.pink.shade400,),
              title: new Text('Home',style: TextStyle(color: Colors.white ),),
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Colors.pink.shade400),
              title: new Text('Profile',style: TextStyle(color: Colors.white ),),
            )
          ],
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}



