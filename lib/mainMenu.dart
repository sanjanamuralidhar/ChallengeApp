
import 'package:ChallengeApp/bookMarked.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:200,
      child: Drawer(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height:100,
            child: DrawerHeader(
              child: Row(
                children: <Widget>[
                  Text(
                    'Instagram',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'BerkshireSwash'),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
              title: Row(
                children: <Widget>[
                  Icon(
                    Icons.bookmark,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'bookMarked',style:TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookMarked(),
                    ));
              }),
        ],
      )),
    );
  }
}
