import 'dart:convert';

import 'package:flutter_idn_notes_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_idn_notes_app/data/datasources/config.dart';
import 'package:flutter_idn_notes_app/data/models/request/register_request_model.dart';
import 'package:flutter_idn_notes_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class AuthRemoteDatasource {
  //register
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel data) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/register'),
      body: data.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  //login
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  //logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return const Right('Logout success');
    } else {
      return Left(response.body);
    }
  }
}
