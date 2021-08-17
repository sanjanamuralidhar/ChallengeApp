class Category{
  int id;
  String channelname;
  String title;
  String high_thumbnail;
  String low_thumbnail;
  String medium_thumbnail;

    @override
  String toString() {
    return toJson().toString();
  }


  Map<String,dynamic> toJson() {
    Map<String,dynamic> json = {};
    if(id != null) json['id'] = id;
    if(channelname != null) json['channelname'] = channelname;
    if(high_thumbnail != null) json['high thumbnail'] = high_thumbnail;
    if(low_thumbnail != null) json['low thumbnail'] = low_thumbnail;
    if(medium_thumbnail != null) json['medium thumbnail'] = medium_thumbnail;
    if(title!= null) json['title'] = title;
    return json;
  }

  categoryMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['channelname'] = channelname;
    mapping['title'] = title;
    mapping['high_thumbnail'] = high_thumbnail;
    mapping['low_thumbnail'] = low_thumbnail;
    mapping['medium_thumbnail'] = medium_thumbnail;
    return mapping;
  }
}