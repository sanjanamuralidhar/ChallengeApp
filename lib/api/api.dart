import 'dart:async';

import 'package:ChallengeApp/Model/commentModel.dart';
import 'package:ChallengeApp/Model/detailModel.dart';
import 'package:ChallengeApp/api/httpManager.dart';
import 'package:ChallengeApp/utils/utils.dart';

abstract class ApiRepository {
  Future<List<DetailModel>> getDetails();
  Future<List<CommentModel>> getComments();
}

class Api implements ApiRepository {

  @override
  Future<List<DetailModel>> getDetails() async {
    // await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.get(url: 'https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas');
    print(result);
    return DetailModel.listFromJson(result);
  }

  Future<List<CommentModel>> getComments() async {
    final result = await UtilAsset.loadJson("assets/data.json");
    // final result = await httpManager.get(url: 'http://cookbookrecipes.in/test.php');
    print(result['comments']);
    return CommentModel.listFromJson(result['comments']);
  }

  
  static Future<List<DetailModel>> getCartItem() async {
    final result = await UtilAsset.loadJson("assets/data/cartItems.json");
    return DetailModel.listFromJson(result['data']['CartItems']);
  }

}
