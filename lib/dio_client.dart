import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'buku_test.dart';
import 'post.dart';

class DioClient {
  final Dio dio = Dio();
  static const baseURL = "http://10.0.2.2";
  static const postEndpoint = baseURL + "/api/buku";
  static const postEndpointCreate = "http://10.0.2.2/api/buku/store";
  static const postEndpointUpdate = "http://10.0.2.2/api/buku/update";
  static const postEndpointDelete = "http://10.0.2.2/api/buku/destroy";

  Future<Buku> fetchPost(int postId) async {
    try {
      final response = await dio.get(postEndpoint + "/show/$postId");
      debugPrint(response.toString());
      return Buku.fromJson(response.data[0]);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to load post: $postId");
    }
  }

  Future<Buku> fetchPosted() async {
    try {
      final response = await dio.get(postEndpoint);
      debugPrint(response.toString());
      return Buku.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to load post");
    }
  }

  Future<List<Buku>> fetchPosts() async {
    try {
      final response = await dio.get(postEndpoint);
      debugPrint(response.toString());
      return Buku.listFromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to load all post: ");
    }
  }

  Future<Buku> createPost( String judul,  int pengarang_id, String genre) async {
    try {
      final response = await dio.post(
        postEndpointCreate,
        queryParameters: {
          "judul": judul,
          "pengarang_id": pengarang_id,
          "genre": genre,
        },
      );
      debugPrint(response.toString());
      return Buku.fromJson(response.data[0]);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to create post: ");
    }
  }

  Future<Buku> updatePost(
      int postId, String judul, int pengarang_id, String genre) async {
    try {
      final response = await dio.post(
        postEndpointUpdate + "/$postId",
        data: {
          "judul": judul,
          "pengarang_id": pengarang_id,
          "genre": genre,
        },
      );
      debugPrint(response.toString());
      return Buku.fromJson(response.data[0]);
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to update post: ");
    }
  }

  Future<void> deletePost(int postId) async {
    try{
      await dio.get(postEndpointDelete + "/$postId");
      debugPrint('Delete Succes');
    } on DioError catch (e) {
      debugPrint("status code: ${e.response?.statusCode.toString()}");
      throw Exception("failed to delete post: $postId");

    }
  }
}
