import 'package:ChallengeApp/apptheme.dart';
import 'package:ChallengeApp/main_Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/api.dart';
import 'bloc/BlocDetail/bloc.dart';
import 'bloc/commentBloc/bloc.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DetailBloc detailBloc;
  CommentBloc commentBloc;


  @override
  void initState() {
    detailBloc = DetailBloc(repository: Api());
     commentBloc = CommentBloc(repository: Api());
    super.initState();
  }

  @override
  void dispose() {
    detailBloc.close();
     commentBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider<DetailBloc>(
        create: (context) => detailBloc,
      ),
       BlocProvider<CommentBloc>(
        create: (context) => commentBloc,
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      // home:DashBoardPage(),
       home: MainNavigation(),
//      home:HomePage(),
    ));
  }
}

