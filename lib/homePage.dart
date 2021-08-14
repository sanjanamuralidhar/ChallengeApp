import 'package:ChallengeApp/comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import 'Model/detailModel.dart';
import 'bloc/BlocDetail/bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class TodoList {
  List<TodoItem> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class TodoItem {
  String title;
  bool done;

  TodoItem({this.title, this.done});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['done'] = done;

    return m;
  }
}

class _HomePageState extends State<HomePage> {
  DetailBloc detailBloc;
  bool pressed = false;
  final LocalStorage storage = new LocalStorage('some_key');
  final TodoList list = new TodoList();


  @override
  void initState() {
    detailBloc = BlocProvider.of<DetailBloc>(context);
    detailBloc.add(FetchDetailEvent());
    super.initState();
  }

  _saveToStorage() {
    storage.setItem('todos', list.toJSONEncodable());
  }

   _addItem(String title) {
    setState(() {
      final item = new TodoItem(title: title, done: false);
      list.items.add(item);
      _saveToStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Icon(
                      Icons.more_vert,
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
                      onTap: (){
                        setState(() {
                          pressed = !pressed;
                           _addItem(item.id);
                        });
                      },
                      child:pressed?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.bookmark),
                    ):Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.bookmark_border),
                    )

                    )
                    
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
                        Text('62,707 others')
                      ],
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
}
