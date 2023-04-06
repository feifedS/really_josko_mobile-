import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:last/dao/dao.dart';
import 'package:last/models/api_models.dart';
import 'package:last/models/category_model.dart';
import 'package:last/models/service_model.dart';
import 'package:last/models/storage_item.dart';
import 'package:last/models/user_model.dart';
import 'package:last/services/storage_service.dart';

import '../models/order_model.dart';

// final _base = "http://192.168.0.8:8000";
final _base = "http://192.168.233.88:8000";
final _signInURL = "/main/token/";
final _refreshURL = "/main/token/refresh/";
final _signUpEndpoint = "/main/api/registration";
const _categoryEndpoint = "/main/api/category";
final _orderEndpoint = "/main/api/order";
final _typeofserviceEndpoint = "/main/api/typeofservices";
// final _graphParamEndpoint = "/api/get_states/";
final _tokenURL = _base + _signInURL;
final _refreshTokenURL = _base + _refreshURL;
final _signUpURL = _base + _signUpEndpoint;
// final _createSessionURL = _base + _sessionEndpoint;
final _categoryURL = _base + _categoryEndpoint;
final _typeofserviceURL = _base + _typeofserviceEndpoint;
final _orderURL = _base + _orderEndpoint;
// final _graphParamURL = _base + _graphParamEndpoint;
final _adminUsername = 'admin';
final _adminPassword = 'admin';

Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await http.post(
    Uri.parse(_tokenURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<bool> registerApi(User userRegisterModel) async {
  Future<bool> success = Future.value(false);
  final http.Response response = await http.post(
    Uri.parse(_signUpURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userRegisterModel.toRegisterJson()),
  );
  if (response.statusCode == 200) {
    success = Future.value(true);
  } else {}

  return success;
}

Future<bool> orderApi(Order orderSendModel) async {
  Future<bool> success = Future.value(false);
  final http.Response response = await http.post(
    Uri.parse(_orderURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(orderSendModel.toOrderJson()),
  );
  if (response.statusCode == 200) {
    success = Future.value(true);
  } else {}

  return success;
}

Future<int> loginApi(UserLogin userLogin) async {
  int userID = 0;

  // блок http-запроса
  final http.Response response = await http.post(
    Uri.parse(_tokenURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );

  if (response.statusCode == 200) {
    Token token = Token.fromJson(json.decode(response.body));
    Map<String, dynamic> userCreds = token.fetchUser(token.token);

    StorageService().writeSecureData(StorageItem("token", token.token));
    print("RRRRRRRRRRRR: ${token.refreshToken}");
    StorageService()
        .writeSecureData(StorageItem("refreshToken", token.refreshToken));

    UserDao userDao = UserDao();
    userDao.addTokenToDb(token.token, token.refreshToken);
    // print("INNNNNNNNNNNNN: ${userDao.getUserToken()}");
    var users = await userDao.getUserToken();
    // users.forEach((row) => {print(row)});

    userID = userCreds.values.last;
    return userID;
  } else {
    throw Exception(json.decode(response.body));
  }
}

// Future<List<Category>> getCategories(Token token) async {
//   List<Category> categories = [];
//   final http.Response response = await http.get(
//     Uri.parse(_categoryURL),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       // 'HttpHeaders.authorizationHeader': 'token',
//       'Authorization': 'Bearer ${token.token}',
//     },
//   );
//   // print("Token: $token");
//   // print(
//   //     "RESDPONSEEEEEEEEEEEEEEEEEEEEEEEEL   ${utf8.decode(response.bodyBytes)}");
// }

// Future<Token> refreshToken(Token token) async {
//   final http.Response response = await http.post(
//     Uri.parse(_refreshTokenURL),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//     },
//     body: jsonEncode({'refresh': token.refreshToken}),
//   );

//   if (response.statusCode == 200) {
//     var tokenJson = json.decode(response.body);
//     token.token = tokenJson['access'];
//     StorageService().writeSecureData(StorageItem("token", token.token));
//   } else {
//     throw Exception(json.decode(response.body));
//   }

//   return token;
// }

// Future<List<Category>> getCategories(Token token) async {
//   final http.Response response = await http.get(
//     Uri.parse(_categoryURL),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${token.token}',
//     },
//   );

//   // if (response.statusCode != 200) {
//   //   throw Exception('Failed to get categories');
//   // }
//   List<Category> categories = [];
//   if (response.statusCode == 200) {
//     print(
//         "RESDPONSEEEEEEEEEEEEEEEEEEEEEEEEL   ${utf8.decode(response.bodyBytes)}");
//     List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

//     List<Category> categories =
//         data.map((item) => Category.fromJson(item)).toList();
//     categories.forEach((category) {
//       print("Category ID: ${category.id}");
//       print("Category Name: ${category.name}");
//     });
//   } else if (response.statusCode == 401) {
//     var newToken = await refreshToken(token);
//     getTypeOfServices(newToken);
//   }
//   return categories;
// }
Future<Token> refreshToken(Token token) async {
  final http.Response response = await http.post(
    Uri.parse(_refreshTokenURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    },
    body: jsonEncode({'refresh': token.refreshToken}),
  );

  if (response.statusCode == 200) {
    var tokenJson = json.decode(response.body);
    token.token = tokenJson['access'];
    await StorageService().writeSecureData(StorageItem("token", token.token));
  } else {
    throw Exception(json.decode(response.body));
  }

  return token;
}

Future<List<Category>> getCategories(Token token) async {
  final http.Response response = await http.get(
    Uri.parse(_categoryURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.token}',
    },
  );

  List<Category> categories = [];
  if (response.statusCode == 200) {
    // print("RESPONSE: ${utf8.decode(response.bodyBytes)}");
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    categories = data.map((item) => Category.fromJson(item)).toList();
    // print("FFFFFFFFFFAAAAAAAAAAA:       ${categories}");
  } else if (response.statusCode == 401) {
    var newToken = await refreshToken(token);
    categories = await getCategories(newToken);
  } else {
    throw Exception('Failed to get categories');
  }
  return categories;
}

Future<List<TypeOfService>> getTypeOfServices(Token token) async {
  final http.Response response = await http.get(
    Uri.parse(_typeofserviceURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.token}',
    },
  );

  List<TypeOfService> typeofservices = [];

  if (response.statusCode == 200) {
    // print("RRRRRRRRRRRRRRRRRRRRRRRR   ${utf8.decode(response.bodyBytes)}");
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    typeofservices = data.map((item) => TypeOfService.fromJson(item)).toList();

    print(typeofservices);
  } else if (response.statusCode == 401) {
    var newToken = await refreshToken(token);
    getTypeOfServices(newToken);
  }

  return typeofservices;
}
