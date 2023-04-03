import 'package:last/models/category_model.dart';
import 'package:last/services/storage_service.dart';

import '../models/api_models.dart';
import '../models/service_model.dart';
import '../repository/request_repository.dart';

class RequestController {
  RequestRepository _userRepo = RequestRepository();

  Future<List<Category>> getCategory(String string) async {
    String? accessToken = await StorageService().readSecureData("token");
    String? refreshToken =
        await StorageService().readSecureData("refreshToken");

    Token token = Token(token: accessToken!, refreshToken: refreshToken!);

    return await _userRepo.getCategory(token);
  }

  Future<List<TypeOfService>> getTypeOfService(String string) async {
    String? accessToken = await StorageService().readSecureData("token");
    String? refreshToken =
        await StorageService().readSecureData("refreshToken");

    Token token = Token(token: accessToken!, refreshToken: refreshToken!);

    return await _userRepo.getTypeOfService(token);
  }
}
