import 'dart:ffi';

import 'package:last/models/api_models.dart';
import 'package:last/models/category_model.dart';
import 'package:last/models/service_model.dart';

abstract class IRequestRepository {
  Future<List<Category>> getCategory(Token token);

  Future<List<TypeOfService>> getTypeOfService(
    Token token,
  );

  Future<bool> order(
    Token Token,
    String type_of_service,
    String times_pick,
  );
}
