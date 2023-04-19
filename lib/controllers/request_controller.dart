import 'package:last/models/booking_model.dart';
import 'package:last/models/category_model.dart';
import 'package:last/services/storage_service.dart';

import '../models/api_models.dart';
import '../models/barber_model.dart';
import '../models/service_model.dart';
import '../repository/request_repository.dart';

// class RequestController {
//   RequestRepository _userRepo = RequestRepository();

//   Future<List<Category>> getCategory(String string) async {
//     String? accessToken = await StorageService().readSecureData("token");
//     String? refreshToken =
//         await StorageService().readSecureData("refreshToken");

//     Token token = Token(token: accessToken!, refreshToken: refreshToken!);

//     return await _userRepo.getCategory(token);
//   }

//   Future<List<TypeOfService>> getTypeOfService(String string) async {
//     String? accessToken = await StorageService().readSecureData("token");
//     String? refreshToken =
//         await StorageService().readSecureData("refreshToken");

//     Token token = Token(token: accessToken!, refreshToken: refreshToken!);

//     return await _userRepo.getTypeOfService(token);
//   }

//   Future<bool> orderController(
//       String string, String type_of_service, String times_pick) async {
//     String? accessToken = await StorageService().readSecureData("token");
//     String? refreshToken =
//         await StorageService().readSecureData("refreshToken");

//     Token token = Token(token: accessToken!, refreshToken: refreshToken!);
//     // late String type_of_service;
//     // late String times_pick;
//     return await _userRepo.order(
//       token,
//       type_of_service,
//       times_pick,
//     );
//   }
// }
class RequestController {
  final RequestRepository _requestRepo = RequestRepository();

  Future<List<Category>> getCategory(String string) async {
    Token token = await _getToken();
    return await _requestRepo.getCategory(token);
  }

  Future<List<TypeOfService>> getTypeOfService(String string) async {
    Token token = await _getToken();
    return await _requestRepo.getTypeOfService(token);
  }

  Future<List<Barber>> getBarber(String string) async {
    Token token = await _getToken();
    return await _requestRepo.getBarber(token);
  }

  Future<bool> bookingController(String string, String type_of_service,
      String barber, String date, String time) async {
    Token token = await _getToken();
    return await _requestRepo.booking(
        token, type_of_service, barber, date, time);
  }

  Future<List<String>> getBooking(
      String string, String barber, String date) async {
    Token token = await _getToken();
    return await _requestRepo.getBooking(
      token,
      barber,
      date,
    );
  }

  // Future<List<String>> timesController(
  //     String string, String barber, String times_pick) async {
  //   Token token = await _getToken();
  //   return await _requestRepo.getBarberTimes(token, barber, times_pick);
  // }

  Future<Token> _getToken() async {
    String? accessToken = await StorageService().readSecureData("token");
    String? refreshToken =
        await StorageService().readSecureData("refreshToken");
    return Token(token: accessToken!, refreshToken: refreshToken!);
  }
}
