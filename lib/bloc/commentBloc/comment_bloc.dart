import 'package:ChallengeApp/Model/commentModel.dart';
import 'package:ChallengeApp/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {

  ApiRepository repository;

  CommentBloc({@required this.repository}) : super(null);

  @override
  // ignore: todo
  // TODO: implement initialState
  // ignore: override_on_non_overriding_member
  CommentState get initialState => CommentInitialState();

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is FetchCommentEvent) {
      yield CommentLoadingState();
      try {
        List<CommentModel> comments = await repository.getComments();
        print('............bloc ......${comments[0].comments}');
        yield CommentLoadedState(comments: comments);
      } catch (e) {
        yield CommentErrorState(message: e.toString());
      }
    }
  }

}