

import 'package:ChallengeApp/comments.dart';
import 'package:ChallengeApp/configs/sharedPref.dart';
import 'package:ChallengeApp/mainMenu.dart';
import 'package:ChallengeApp/service/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Model/Categorymodel.dart';
import 'Model/detailModel.dart';
import 'bloc/BlocDetail/bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstHalf;
  String secondHalf;
  var _category = Category();
  var _categoryService = CategoryService();

  List toggled = List();

  bool flag = true;
  final String description =
      "this image is so wonderful. this reminds me of my childhood great experience i wonder why I posted this now.";

  DetailBloc detailBloc;
  bool pressed = false;
  List<DetailModel> _bookMarked;
  SharedPref sharedPref = SharedPref();
  // DetailModel userSave = DetailModel();
  DetailModel todo;
  List<Category> _categoryList = List<Category>();

  @override
  void initState() {
    detailBloc = BlocProvider.of<DetailBloc>(context);
    detailBloc.add(FetchDetailEvent());
    if (description.length > 50) {
      firstHalf = description.substring(0, 50);
      secondHalf = description.substring(50, description.length);
    } else {
      firstHalf = description;
      secondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainMenu(),
      appBar: AppBar(
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.camera_enhance_sharp),
          ),
          Text("Instagram")
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.send),
          )
        ],
      ),
      body: _buildDetailBloc(),
    );
  }

  Widget _buildDetailBloc() {
    return Container(
      child: BlocListener<DetailBloc, DetailState>(
        listener: (context, state) {
          if (state is DetailErrorState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailInitialState) {
              print('category initial state');
            } else if (state is DetailLoadingState) {
              print('Category Loading State');
            } else if (state is DetailLoadedState) {
              return buildDetailPage(context, state.details);
            } else if (state is DetailErrorState) {
              return Container(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildDetailPage(BuildContext context, List<DetailModel> _detail) {
    List<DetailModel> detail = _detail == null ? [] : _detail;
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: detail.length,
          itemBuilder: (context, index) {
            final item = detail[index];
            bool isSaved = toggled.contains(item);
            return Container(
                child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(item.high_thumbnail),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.channelname),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => _onOpenMore(),
                      child: Icon(
                        Icons.more_vert,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  // height: MediaQuery.of(context).size.height*.50,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Image.network(item.medium_thumbnail),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.comment),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.send),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                        onTap: ()  {
                          setState(()  {
                            if (isSaved) {
                              toggled.remove(item);
                              _categoryService.deleteCategory(item.channelname);
                            } else {
                              toggled.add(item);
                              _category.channelname = item.channelname;
                              _category.title = item.title;
                              _category.high_thumbnail = item.high_thumbnail;
                              _category.medium_thumbnail =
                                  item.medium_thumbnail;
                              _category.low_thumbnail = item.low_thumbnail;
                              _categoryService.saveCategory(_category);
                            }
                          });
                        },
                        child: toggled.contains(item)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.bookmark),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.bookmark_border),
                              ))
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(item.low_thumbnail),
                      ),
                    ),
                    Row(
                      children: [
                        Text('Liked By '),
                        Text('neeharika_boda'),
                        Text('and'),
                        Text('62,707 others'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Text('Liked By '),
                    // Text('neeharika_boda'),
                    // Text('and'),
                    // Text('62,707 others'),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      padding: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: secondHalf.isEmpty
                          ? new Text(firstHalf)
                          : new Column(
                              children: <Widget>[
                                new Text(flag
                                    ? (firstHalf + "...")
                                    : (firstHalf + secondHalf)),
                                new InkWell(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new Text(
                                        flag ? "show more" : "show less",
                                        style:
                                            new TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Comments()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("View all Comments"),
                      ),
                    )
                  ],
                )
              ],
            ));
          }),
    );
  }

  void _onOpenMore() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * .40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Report'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Turn on Post Notification'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Copy Link'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Share To'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Un follow'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Mute'),
              ),
            ],
          ),
        );
      },
    );
  }
}
//     pressed =! pressed;
//      setState(() {

//   if (pressed==true && detail.contains(item)) {
//     setState(() {
//       toggled.add(item);
//        Scaffold.of(context).showSnackBar(SnackBar(
// content: new Text("Saved!"),
// duration: const Duration(milliseconds: 500)));
//     });
//   } else if (pressed==false && toggled.contains(item)) {
//     toggled.remove(item);
//    Scaffold.of(context).showSnackBar(SnackBar(
// content: new Text("Removed!"),
// duration: const Duration(milliseconds: 500)));
//   }
// });
