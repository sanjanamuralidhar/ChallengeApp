import 'package:ChallengeApp/bloc/commentBloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Model/commentModel.dart';

class Comments extends StatefulWidget {
  const Comments({ Key key }) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {

  CommentBloc commentBloc;

  @override
  void initState() {
    commentBloc = BlocProvider.of<CommentBloc>(context);
    commentBloc.add(FetchCommentEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments'),),
      body: _buildCommentsBloc(),
    );
  }

    Widget _buildCommentsBloc() {
    return Container(
      child: BlocListener<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state is CommentErrorState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentInitialState) {
              print('category initial state');
            } else if (state is CommentLoadingState) {
              print('Category Loading State');
            } else if (state is CommentLoadedState) {
              return buildDetailPage(context, state.comments);
            } else if (state is CommentErrorState) {
              return Container(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildDetailPage(BuildContext context, List<CommentModel> _comments) {
    List<CommentModel> comments = _comments == null ? [] : _comments;
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final item = comments[index];
            return Container(
                child: Column(
              children: [
                Row(
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.username),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.comments),
                  )
                  ],
                ),
            
              ],
            ));
          }),
    );
  }
}