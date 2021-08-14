import 'dart:developer';
import 'package:ChallengeApp/configs/application.dart';
import 'package:ChallengeApp/homePage.dart';
import 'package:ChallengeApp/utils/utils.dart';
import 'package:flutter/material.dart';

// import 'api/api.dart';


class MainNavigation extends StatefulWidget {
  MainNavigation({Key key,}) : super(key: key);

  @override
  _MainNavigationState createState() {
    return _MainNavigationState();
  }
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

int neighbourid;

  @override
  void initState() {
    super.initState();
  }


  ///On change tab bottom menu
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///Show notification received
  Future<void> _showNotification(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ///List bottom menu
  List<BottomNavigationBarItem> _bottomBarItem(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        // ignore: deprecated_member_use
        title: Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(''),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        // ignore: deprecated_member_use
        title: Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(''),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined),
        // ignore: deprecated_member_use
        title: Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(''),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark_border),
        // ignore: deprecated_member_use
        title: Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(''),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        // ignore: deprecated_member_use
        title: Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(''),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              HomePage(),
              // WishList(),
              // MessageList(),
              // BookMarked(),
              // Profile(),
            ],
          ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItem(context),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).primaryColorDark,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

}
