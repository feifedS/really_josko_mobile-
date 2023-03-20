import 'package:last/models/api_models.dart';
import 'package:last/models/user_model.dart';
import 'package:last/repository/user_repository.dart';

class HomeController {
  UserRepository _userRepo = UserRepository();

  // Future<List<User>> getAllUsers() {
  //   return _userRepo.getAll();
  // }

  Future<bool> registerUser(
      String username,
      String firstname,
      String lastname,
      String email,
      String password1,
      String password2,
      String age,
      String genderId,
      String phoneNumber) async {
    print("YA V CONTROLLERE");
    return await _userRepo.register(username, firstname, lastname, email,
        password1, password2, age, genderId, phoneNumber);
  }

  Future<String> loginUser(String username, String password) async {
    return await _userRepo.login(username, password);
  }

  Future<void> removeBook(int id) {
    return _userRepo.delete(id);
  }
}
