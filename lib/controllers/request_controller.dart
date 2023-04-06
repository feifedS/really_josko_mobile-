import 'package:last/models/category_model.dart';
import 'package:last/services/storage_service.dart';

import '../models/api_models.dart';
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

  Future<bool> orderController(
      String string, String type_of_service, String times_pick) async {
    Token token = await _getToken();
    return await _requestRepo.order(token, type_of_service, times_pick);
  }

  Future<Token> _getToken() async {
    String? accessToken = await StorageService().readSecureData("token");
    String? refreshToken =
        await StorageService().readSecureData("refreshToken");
    return Token(token: accessToken!, refreshToken: refreshToken!);
  }
}
