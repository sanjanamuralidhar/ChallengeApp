import 'package:ChallengeApp/Model/detailModel.dart';
import 'package:flutter/material.dart';
import 'configs/sharedPref.dart';

class Demo extends StatefulWidget {
  @override
  DemoView createState() {
    return DemoView();
  }
}

class DemoView extends State<Demo> {
  SharedPref sharedPref = SharedPref();
  DetailModel userSave = DetailModel();
  DetailModel userLoad = DetailModel();

  loadSharedPrefs() async {
    try {
      DetailModel user = DetailModel.fromJson(await sharedPref.read("user"));
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Loaded!"),
          duration: const Duration(milliseconds: 500)));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Nothing found!"),
          duration: const Duration(milliseconds: 500)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  height: 50.0,
                  width: 300.0,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Name"),
                    onChanged: (value) {
                      setState(() {
                        userSave.channelname = value;
                      });
                    },
                  )),
              Container(
                  height: 50.0,
                  width: 300.0,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Age"),
                    onChanged: (value) {
                      setState(() {
                        userSave.high_thumbnail = value;
                      });
                    },
                  )),
              Container(
                  height: 50.0,
                  width: 300.0,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Location"),
                    onChanged: (value) {
                      setState(() {
                        userSave.id = value;
                      });
                    },
                  )),
            ],
          ),
        ),
        Container(
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  sharedPref.save("user", userSave);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: new Text("Saved!"),
                      duration: const Duration(milliseconds: 500)));
                },
                child: Text('Save', style: TextStyle(fontSize: 20)),
              ),
              RaisedButton(
                onPressed: () {
                  loadSharedPrefs();
                },
                child: Text('Load', style: TextStyle(fontSize: 20)),
              ),
              RaisedButton(
                onPressed: () {
                  sharedPref.remove("user");
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: new Text("Cleared!"),
                      duration: const Duration(milliseconds: 500)));
                  setState(() {
                    userLoad = DetailModel();
                  });
                },
                child: Text('Clear', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Name: " + (userLoad.id ?? ""),
                  style: TextStyle(fontSize: 16)),
              Text("Age: " + (userLoad.channelname?? ""),
                  style: TextStyle(fontSize: 16)),
              Text("Location: " + (userLoad.high_thumbnail ?? ""),
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}