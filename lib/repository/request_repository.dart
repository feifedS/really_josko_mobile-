import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
// import 'package:flutter_session/flutter_session.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:last/models/api_models.dart';
import 'package:last/models/category_model.dart';
import 'package:last/models/service_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:last/api_connection/api_connection.dart';
import 'package:last/repository/request_interface.dart';

class RequestRepository implements IRequestRepository {
  @override
  Future<List<Category>> getCategory(Token token) async {
    return await getCategories(token);
  }

  @override
  Future<List<TypeOfService>> getTypeOfService(Token token) async {
    return await getTypeOfServices(token);
  }
}
