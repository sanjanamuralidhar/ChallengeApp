import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Model/detailModel.dart';
import 'bloc/bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   DetailBloc detailBloc;

  @override
  void initState() {
    detailBloc = BlocProvider.of<DetailBloc>(context);
    detailBloc.add(FetchDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children:[
            Icon(Icons.camera),
            Text("Instagram")
          ]
        ),
        actions: [Icon(Icons.send)],),
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

  Widget buildDetailPage(BuildContext context,List<DetailModel> _detail){
     List<DetailModel> detail = _detail == null ? [] : _detail;
    return Container(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: detail.length,
                  itemBuilder: (context, index) {
                    final item = detail[index];
                    return Container(
          child:Column(children: [
            Row(children: [
              Row(
                children: [
                  Image.network(item.high_thumbnail),
                  Text(item.channelname),
                ],
              ),
              Spacer(),
              Icon(Icons.more_vert,),

            ],),
            SizedBox(
              height: MediaQuery.of(context).size.height*.50,
              width: MediaQuery.of(context).size.width*1,
              child:Image.network(item.medium_thumbnail),
            ),
          Row(children: [
            Row(children: [
              Icon(Icons.favorite),
              Icon(Icons.comment),
              Icon(Icons.send),
            ],),
            Spacer(),
            Icon(Icons.bookmark),
          ],),
          Row(children: [
            Image.network(item.low_thumbnail),
            Text('Liked By '),
            GestureDetector(
              onTap:(){},
              child:Text("View all Comments"),
            )
          ],)
          ],)
        );
                  }),
            );
  }
}