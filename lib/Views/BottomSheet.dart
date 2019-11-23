import 'package:flutter/material.dart';
import 'package:list_view/helpers.dart';

class MyBottomSheetLayout extends StatefulWidget {
  @override
  _MyBottomSheetLayoutState createState() => _MyBottomSheetLayoutState();
}
class _MyBottomSheetLayoutState extends State<MyBottomSheetLayout> {
  bool isSubmitted = false;
  final bodyTextEditController = TextEditingController();
  final titleTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      curve: Curves.bounceIn,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: new BoxDecoration(
          color:  isSubmitted ? Colors.greenAccent : Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0))),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
              controller: titleTextEditController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Type your title...',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
              controller: bodyTextEditController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)),
            onPressed: () {
                //isSubmitted = API.postUsers(body: textEditController.text) as bool;
                print(bodyTextEditController.text);
                API.postComments(body: bodyTextEditController.text, name: titleTextEditController.text).then((response){
                  setState(() {
                    isSubmitted = response;
                  });
                });
              //Navigator.pop(context);
            },
            color: Colors.red,
            textColor: Colors.white,
            child: Text( isSubmitted? "Submitted" : "Submit",
                style: TextStyle(fontSize: 14)
            ),
          ),
        ],
      ),
    ); // return your bottomSheetLayout
  }
}
