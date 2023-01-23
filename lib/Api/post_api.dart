import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: "http://87.107.78.234:60005/login/index.php?tag=webtest")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @GET("")
  Future<Post> getTasks();
}

@JsonSerializable()
class Post{
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "age")
  String age;


  Post({required this.name,required this.age});

  factory Post.fromJson(Map<String, dynamic> json) =>  _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

