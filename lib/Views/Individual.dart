import 'package:flutter/material.dart';
import 'package:list_view/Models/Comments.dart';

class Individual extends StatelessWidget {

  final Comments comment;
  Individual(this.comment);

  @override
  Widget build(BuildContext context) {
      final topContentText = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Text(
            comment.name,
            style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Expanded(
                  flex: 6,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        comment.body,
                        style: TextStyle(color: Colors.white, fontSize: 16.0,),
                      ))),
            ],
          ),
        ],
      );

      final topContent = Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10.0),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("drive-steering-wheel.jpg"),
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 1,
            padding: EdgeInsets.fromLTRB(25,80,10,10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
            child: Center(
              child: topContentText,
            ),
          ),
          Positioned(
            left: 10.0,
            top: 50.0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          )
        ],
      );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent],
      ),
    );
  }
}