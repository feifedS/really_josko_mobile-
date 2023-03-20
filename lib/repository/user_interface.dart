import 'package:last/models/user_model.dart';
import 'package:last/models/api_models.dart';

abstract class IUserRepository {
  Future<List<User>> getAll();

  Future<User?> getOne(int id);

  Future<bool> register(
      String username,
      String firstname,
      String lastname,
      String email,
      String password1,
      String password2,
      String age,
      String genderId,
      String phoneNumber);

  Future<String> login(String username, String password);

  Future<void> update(User user);

  Future<void> delete(int id);
}
