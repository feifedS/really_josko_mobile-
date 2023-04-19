import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:last/dao/dao.dart';
import 'package:last/models/api_models.dart';
import 'package:last/models/booking_model.dart';
import 'package:last/models/category_model.dart';
import 'package:last/models/service_model.dart';
import 'package:last/models/storage_item.dart';
import 'package:last/models/user_model.dart';
import 'package:last/services/storage_service.dart';

import '../models/barber_model.dart';
import '../models/order_model.dart';

// final _base = "http://192.168.0.8:8000";
final _base = "http://172.16.58.13:8000";
final _signInURL = "/main/token/";
final _refreshURL = "/main/token/refresh/";
final _signUpEndpoint = "/main/api/registration";
const _categoryEndpoint = "/main/api/category";
final _orderEndpoint = "/main/api/bookingpost";
final _typeofserviceEndpoint = "/main/api/typeofservices";
final _barberEndpoint = "/main/api/barbergget";
final _timesEndpoint = "/main/api/times";
final _bookingEndpoint = "/main/api/booking";
// final _graphParamEndpoint = "/api/get_states/";
final _tokenURL = _base + _signInURL;
final _refreshTokenURL = _base + _refreshURL;
final _signUpURL = _base + _signUpEndpoint;
// final _createSessionURL = _base + _sessionEndpoint;
final _categoryURL = _base + _categoryEndpoint;
final _typeofserviceURL = _base + _typeofserviceEndpoint;
final _orderURL = _base + _orderEndpoint;
final _barberURL = _base + _barberEndpoint;
final _timesURL = _base + _timesEndpoint;
final _bookingURL = _base + _bookingEndpoint;

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
// Future<Token> getToken(UserLogin userLogin, {Token? token}) async {
//   if (token == null) {
//     // No token provided, obtain a new one using userLogin credentials
//     token = await _fetchToken(userLogin);
//   }

//   final http.Response response = await http.post(
//     Uri.parse(_tokenURL),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(userLogin.toDatabaseJson()),
//   );
//   if (response.statusCode == 200) {
//     return Token.fromJson(json.decode(response.body));
//   } else if (response.statusCode == 401) {
//     throw Exception(json.decode(response.body));
//     // // Refresh token
//     // Token refreshedToken = await refreshToken(token);
//     // token.token = refreshedToken.token;
//     // // Retry original API request with new token
//     // return await getToken(userLogin, token: token);
//   } else {
//     print(json.decode(response.body).toString());
//     throw Exception(json.decode(response.body));
//   }
// }

Future<Token> _fetchToken(UserLogin userLogin) async {
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

Future<bool> bookingAPI(sendBooking orderSendModel, Token token) async {
  Future<bool> success = Future.value(false);
  final http.Response response = await http.post(
    Uri.parse(_orderURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.token}',
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

    userID = userCreds.values.last;
    return userID;
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<Token> refreshToken(Token token) async {
  // if (token == null) {
  //   // No token provided, obtain a new one using userLogin credentials
  //   token = await _fetchToken(userLogin);
  // }
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
    // throw Exception(json.decode(response.body));
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

Future<List<Booking>> getBookings(Token token) async {
  final http.Response response = await http.get(
    Uri.parse(_bookingURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.token}',
    },
  );

  List<Booking> typeofservices = [];

  if (response.statusCode == 200) {
    // print("RRRRRRRRRRRRRRRRRRRRRRRR   ${utf8.decode(response.bodyBytes)}");
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    typeofservices = data.map((item) => Booking.fromJson(item)).toList();

    print(typeofservices);
  } else if (response.statusCode == 401) {
    var newToken = await refreshToken(token);
    getTypeOfServices(newToken);
  }

  return typeofservices;
}

Future<List<Barber>> getBarbers(Token token) async {
  final http.Response response = await http.get(
    Uri.parse(_barberURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.token}',
    },
  );

  List<Barber> barbers = [];

  if (response.statusCode == 200) {
    // print("RRRRRRRRRRRRRRRRRRRRRRRR   ${utf8.decode(response.bodyBytes)}");
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    barbers = data.map((item) => Barber.fromJson(item)).toList();

    print('dddddddddddddddddddddddddddd$barbers');
  } else if (response.statusCode == 401) {
    var newToken = await refreshToken(token);
    getBarbers(newToken);
  }

  return barbers;
}

Future<List<String>> getBookingsAPI(
    Booking bookingSendModel, Token token) async {
  final http.Response response = await http.post(
    Uri.parse(_timesURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.token}',
    },
    body: jsonEncode(bookingSendModel.toOrderJson()),
  );
  List<String> times = [];

  if (response.statusCode == 200) {
    List<dynamic> timesjson = jsonDecode(utf8.decode(response.bodyBytes));
    timesjson.forEach(
      (element) => times.add(element),
    );

    print("ccccccccccccccccccc$times");
  } else if (response.statusCode == 401) {
    var newToken = await refreshToken(token);
    getBookingsAPI(bookingSendModel, newToken);
  } else {}

  return times;
  // return Future.value(times);
}

// Future<List<String>?> getBookingsAPI(
//     Booking bookingSendModel, Token token) async {
//   List<String>? times;
//   final http.Response response = await http.post(
//     Uri.parse(_timesURL),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${token.token}',
//     },
//     body: jsonEncode(bookingSendModel.toOrderJson()),
//   );
//   if (response.statusCode == 200) {
//     List<dynamic> timesjson = jsonDecode(utf8.decode(response.bodyBytes));
//     if (timesjson.isNotEmpty) {
//       times = [];
//       timesjson.forEach(
//         (element) => times?.add(element),
//       );
//       print("ccccccccccccccccccc$times");
//     }
//   } else if (response.statusCode == 401) {
//     var newToken = await refreshToken(token);
//     return getBookingsAPI(bookingSendModel, newToken);
//   } else {}

//   return Future.value(times);
// }
