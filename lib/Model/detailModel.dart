
class DetailModel{
  String id;
  String channelname;
  String title;
  String high_thumbnail;
  String low_thumbnail;
  String medium_thumbnail;
  // List<String> tags;

  DetailModel({
    this.channelname,
    this.high_thumbnail,
    this.id,
    this.low_thumbnail,
    this.medium_thumbnail,
    // this.tags,
    this.title,
  });
  
   @override
  String toString() {
    return toJson().toString();
  }

  DetailModel.fromJson(Map<String, dynamic> json){
    if(json == null) return;
    id = json['id'];
    channelname = json['channelname'];
    high_thumbnail = json['high thumbnail'];
    low_thumbnail = json['low thumbnail'];
    medium_thumbnail = json['medium thumbnail'];
    // tags = json['tags'];
    title = json['title'];
  }

  Map<String,dynamic> toJson() {
    Map<String,dynamic> json = {};
    if(id != null) json['id'] = id;
    if(channelname != null) json['channelname'] = channelname;
    if(high_thumbnail != null) json['high thumbnail'] = high_thumbnail;
    if(low_thumbnail != null) json['low thumbnail'] = low_thumbnail;
    if(medium_thumbnail != null) json['medium thumbnail'] = medium_thumbnail;
    // if(tags!= null) json['tags'] = tags;
    if(title!= null) json['title'] = title;
    return json;
  }

  static List<DetailModel> listFromJson(List<dynamic> json) {
    return json == null
    ? List<DetailModel>()
    :json.map((value) => DetailModel.fromJson(value)).toList();
  }

}



