import 'package:ChallengeApp/Model/detailModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DetailState extends Equatable {}

class DetailInitialState extends DetailState {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

class DetailLoadingState extends DetailState {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DetailLoadedState extends DetailState {

  List<DetailModel> details;

  DetailLoadedState({@required this.details});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [details];
}

// ignore: must_be_immutable
class DetailErrorState extends DetailState {

  String message;

  DetailErrorState({@required this.message});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [message];
}