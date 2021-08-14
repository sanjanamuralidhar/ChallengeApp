import 'package:ChallengeApp/comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import 'Model/detailModel.dart';
import 'api/api.dart';
import 'bloc/BlocDetail/bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DetailBloc detailBloc;
  bool pressed = false;
  List<DetailModel> _bookMarked;

  @override
  void initState() {
    detailBloc = BlocProvider.of<DetailBloc>(context);
    detailBloc.add(FetchDetailEvent());
    _loadCartItem();
    super.initState();
  }

  Future<void> _loadCartItem() async {
    final List<DetailModel> result = await Api.getCartItem();
    setState(() {
      _bookMarked = result;
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
                        onTap: () {
                          setState(() {
                            pressed = !pressed;
                          });
                          if(pressed==true){
                            setState(() {
                              _bookMarked.add(item);
                            });
                          }
                          if(pressed == false){
                            setState(() {
                              _bookMarked.remove(item);

                            });
                          }
                        },
                        child: pressed
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

  void _onOpenMore() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height*.40,
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
