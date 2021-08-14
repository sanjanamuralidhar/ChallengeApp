import 'package:ChallengeApp/main_Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/api.dart';
import 'bloc/bloc.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DetailBloc detailBloc;


  @override
  void initState() {
    detailBloc = DetailBloc(repository: Api());
    super.initState();
  }

  @override
  void dispose() {
    detailBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider<DetailBloc>(
        create: (context) => detailBloc,
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:DashBoardPage(),
       home: MainNavigation(),
//      home:HomePage(),
    ));
  }
}

