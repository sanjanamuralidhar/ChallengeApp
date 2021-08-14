import 'package:ChallengeApp/Model/detailModel.dart';
import 'package:ChallengeApp/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {

  ApiRepository repository;

  DetailBloc({@required this.repository}) : super(null);

  @override
  // ignore: todo
  // TODO: implement initialState
  // ignore: override_on_non_overriding_member
  DetailState get initialState => DetailInitialState();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is FetchDetailEvent) {
      yield DetailLoadingState();
      try {
        List<DetailModel> details = await repository.getDetails();
        print('............bloc ......${details[0].channelname}');
        yield DetailLoadedState(details: details);
      } catch (e) {
        yield DetailErrorState(message: e.toString());
      }
    }
  }

}