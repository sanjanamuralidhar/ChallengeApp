import 'package:ChallengeApp/Model/commentModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CommentState extends Equatable {}

class CommentInitialState extends CommentState {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

class CommentLoadingState extends CommentState {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CommentLoadedState extends CommentState {

  List<CommentModel> comments;

  CommentLoadedState({@required this.comments});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [comments];
}

// ignore: must_be_immutable
class CommentErrorState extends CommentState {

  String message;

  CommentErrorState({@required this.message});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [message];
}