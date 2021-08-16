import 'package:ChallengeApp/Model/detailModel.dart';
import 'package:ChallengeApp/configs/sharedPref.dart';
import 'package:flutter/material.dart';

class BookMarked extends StatefulWidget {
  const BookMarked({ Key key }) : super(key: key);

  @override
  _BookMarkedState createState() => _BookMarkedState();
}

class _BookMarkedState extends State<BookMarked> {
  SharedPref sharedPref = SharedPref();
  DetailModel userLoad = DetailModel();

  
  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      DetailModel user = DetailModel.fromJson(await sharedPref.read("user"));
      print(user);
      print('bla bla bla');
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Loaded!"),
          duration: const Duration(milliseconds: 500)));
      setState(() {
        userLoad = user;
        print(user);
      });
    } catch (Excepetion) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Nothing found!"),
          duration: const Duration(milliseconds: 500)));
    }
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(title: Text('BookMark'),),
      body: _buildBody(context),
      
    );
  }

  Widget _buildBody(BuildContext context){
    print(userLoad);
    DetailModel userload = userLoad == null ? [] : userLoad;
    if(userload.id == null){
      Container(child: Text('no data available to show'));}
      else return Container(
        child:SizedBox(
                  // height: MediaQuery.of(context).size.height*.50,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Image.network(userload.medium_thumbnail),
                ),
      );
  }
}