import 'package:ChallengeApp/Model/Categorymodel.dart';
import 'package:ChallengeApp/Model/detailModel.dart';
import 'package:ChallengeApp/configs/sharedPref.dart';
import 'package:ChallengeApp/service/category_service.dart';
import 'package:flutter/material.dart';

class BookMarked extends StatefulWidget {
  const BookMarked({ Key key }) : super(key: key);

  @override
  _BookMarkedState createState() => _BookMarkedState();
}

class _BookMarkedState extends State<BookMarked> {
  SharedPref sharedPref = SharedPref();
  DetailModel userLoad = DetailModel();

  var _categoryService = CategoryService();
  List<Category> _categoryList = List<Category>();

  

  
  @override
  void initState() {
    // loadSharedPrefs();
    getAllCategories();
    super.initState();
  }

getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        var categoryModel = Category();
        categoryModel.channelname = category['channelname'];
        categoryModel.title = category['title'];
        categoryModel.high_thumbnail = category['high_thumbnail'];
        categoryModel.medium_thumbnail = category['medium_thumbnail'];
        categoryModel.low_thumbnail = category['low_thumbnail'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  // loadSharedPrefs() async {
  //   try {
  //     DetailModel user = DetailModel.fromJson(await sharedPref.read("user"));
  //     print(user);
  //     print('bla bla bla');
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //         content: new Text("Loaded!"),
  //         duration: const Duration(milliseconds: 500)));
  //     setState(() {
  //       userLoad = user;
  //       print(user);
  //     });
  //   } catch (Excepetion) {
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //         content: new Text("Nothing found!"),
  //         duration: const Duration(milliseconds: 500)));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //  getAllCategories();
    return Scaffold(
      appBar: AppBar(title: Text('BookMark'),),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context,index){
          final item = _categoryList[index];
          return Container(
        child:SizedBox(
                  // height: MediaQuery.of(context).size.height*.50,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Image.network(item.medium_thumbnail),
                ),
      );
        },)
      // _buildBody(context),
      
    );
  }

  // Widget _buildBody(BuildContext context){
  //   print(userLoad);
  //   DetailModel userload = userLoad == null ? [] : userLoad;
  //   if(userload.id == null){
  //     Container(child: Text('no data available to show'));}
  //     else return Container(
  //       child:SizedBox(
  //                 // height: MediaQuery.of(context).size.height*.50,
  //                 width: MediaQuery.of(context).size.width * 1,
  //                 child: Image.network(userload.medium_thumbnail),
  //               ),
  //     );
  // }
}