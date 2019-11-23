import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:list_view/Models/Comments.dart';
import 'package:list_view/Views/Individual.dart';
import 'package:list_view/helpers.dart';
import 'package:list_view/Views/BottomSheet.dart';

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  int fetchIndex = 2;
  var _controller = ScrollController();
  var comments = new List<Comments>();

  @override
  build(context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _showMyBottomSheet,
          label: Text('New'),
          icon: Icon(Icons.add_comment),
          backgroundColor: Colors.pink,
      ),
      body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .8)),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
          child: NotificationListener<ScrollNotification>(  //https://medium.com/@diegoveloper/flutter-lets-know-the-scrollcontroller-and-scrollnotification-652b2685a4ac
//            onNotification: (scrollNotification) {
//              if (scrollNotification is ScrollUpdateNotification) {
//                //_onStartScroll(scrollNotification.metrics);
//              //Scaffold.of(context).removeCurrentSnackBar();
//              }
//              return;
//            },
            child: ListView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black12,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new Individual(comments[index]),
                            ),
                        );
                      },
                      title: Container(
                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                          child: Text(
                            comments[index].name,
                            style: TextStyle(color: Colors.white, wordSpacing: 2,fontSize: 17, fontWeight: FontWeight.values[7]),
                          )
                      ),
                      subtitle: Text(
                        comments[index].body +"____ $index",
                        style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 14),
                      ),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                    ),
                  );
                },
                itemCount: comments.length,
              ),
          ),
        ),
    );
  }

  initState() {
    super.initState();
    _controller.addListener(() {
        double maxScroll = _controller.position.maxScrollExtent;
        double currentScroll = _controller.position.pixels;
        double delta = 10.0; // or something else..

        print("Maxscroll" + maxScroll.toString());
        print(currentScroll);
        if ( maxScroll - currentScroll <= delta) { // whatever you determine here
          print("scrolling");
          _getUsers(++fetchIndex);
          print("Input Param" + fetchIndex.toString());
        }
    });
    //upon init, load about 9 items
    for(int i=fetchIndex; i<10; i++){
      _getUsers(i);
      fetchIndex = i;
    }
  }

  dispose() {
    super.dispose();
  }

  void _getUsers(int c) {
    API.getComments(c).then((response) {
      setState(() {
        //Iterable list = json.decode(response.body);
        //print(list);
        //this is equivalent to
        //  for each listitem, it will take in the individual model and then return the Comment object
        //then change into a list
        //var c= list.map((model) { return Comments.fromJson(model); });
        comments.add(Comments.fromJson(json.decode(response.body)["message"]));
      });
    });
  }

  void _showMyBottomSheet(){
    // the context of the bottomSheet will be this widget
    //the context here is where you want to show the bottom sheet
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
          return SingleChildScrollView(
            child: MyBottomSheetLayout(), // returns your BottomSheet widget,
          );
        }
      );
    }
}
//
//final snackBar = SnackBar(
//  backgroundColor: Colors.black.withOpacity(0.1),
//  shape: RoundedRectangleBorder(
//    borderRadius: BorderRadius.all(Radius.circular(50)),
//  ),
//  behavior: SnackBarBehavior.floating,
//  elevation: 8,
//  duration: Duration(microseconds: 1),
//  content: Row(
//    mainAxisAlignment: MainAxisAlignment.end,
//    children: <Widget>[
//      Text('Loading ...'),
//    ],
//  ),
//);