import 'package:dio/dio.dart';

import 'package:test_app/data/network/dio_setting.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/user.dart';

class ServerApi {
  DioSettings _dioSettings = DioSettings();
  Dio _dio = Dio();
  Map<String, dynamic> _request;

  static ServerApi _instance = new ServerApi.internal();
  factory ServerApi() => _instance;
  ServerApi.internal() {
    _dioSettings = DioSettings();
    _dio = _dioSettings.dio;
  }

  Future<List<User>> getAllUsers() async {
    _dio.interceptors.add(LogInterceptor());
    try {
      Response response = await _dio.get('/users');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((user) => User.fromJson(user))
            .toList();
      }
    } catch (error) {}
    return [];
  }

  Future<List<Post>> getAllPosts() async {
    _dio.interceptors.add(LogInterceptor());
    try {
      Response response = await _dio.get('/posts');
      if (response.statusCode == 200 && response.data != null) {
        return (response.data as List)
            .map((post) => Post.fromJson(post))
            .toList();
      }
    } catch (error) {
      print(error.toString());
    }
    return [];
  }

  Future<List<Album>> getAllAlbums() async {
    _dio.interceptors.add(LogInterceptor());
    try {
    Response response = await _dio.get('/albums');
    if (response.statusCode == 200 && response.data != null) {
      return (response.data as List)
          .map((album) => Album.fromJson(album))
          .toList();
    }
    } catch (error) {
      print(error.toString());
    }
    return [];
  }
}
