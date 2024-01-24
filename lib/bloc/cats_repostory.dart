import 'dart:convert';
import 'dart:io';

import 'package:bloc_tutorial/bloc/cat_http.dart';
import 'package:http/http.dart' as http;

abstract class ICatsRep {
  Future<List<Cat>> getCats();
}

class CatsRepo implements ICatsRep {
  final baseUrl = 'https://hwasampleapi.firebaseio.com/http.json';
  @override
  Future<List<Cat>> getCats() async {
    final response = await http.get(Uri.parse(baseUrl));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => Cat.fromJson(e)).toList();
      default:
        throw NetworkException(statusCode: response.statusCode.toString(), message: response.body);
    }
  }
}

class NetworkException implements Exception {
  final String statusCode;
  final String message;

  NetworkException({required this.message, required this.statusCode});
}
