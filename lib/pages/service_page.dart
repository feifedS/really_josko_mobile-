import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:http/http.dart' as http;
import 'package:last/controllers/home_controller.dart';
import 'package:last/controllers/request_controller.dart';
import 'package:last/models/api_models.dart';
import 'package:last/models/category_model.dart';
import 'package:last/pages/register_page.dart';
import 'package:last/pages/reset_password.dart';
import 'package:last/services/storage_service.dart';
import '../models/service_model.dart';
import 'home_page.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:last/api_connection/api_connection.dart';
import 'package:last/repository/user_repository.dart';

import 'package:last/models/storage_item.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();

  // создаем объект контроллера
  // final HomeController _homeController = HomeController();
  final RequestController _requestController = RequestController();
}

class _ServiceState extends State<ServicePage> {
  final StorageService _storageService = StorageService();
  String selectedDate = "";

  String? dropdownvalue;
  List<String> itemsCategories = [];
  List<String> itemsTypeOfServices = [];
  late List<Category> categories = [];
  List<TypeOfService> typeofservices = [];
  @override
  void initState() {
    super.initState();
    loadCategories();
    // loadTypeOfServices();
  }

//kk
  Future<void> loadCategories() async {
    List<Category> result = await widget._requestController.getCategory(
      '',
    );
    setState(() {
      categories = result;
      print("QQQQQQQQQQQQQQQQQQQQQQ ${categories.first.name}");
      // itemsCategories.clear();
      // itemsCategories.addAll(categories.map((category) => category.name));
      // dropdownvalue = itemsCategories.first;
    });
  }

  // Future<void> loadTypeOfServices() async {
  //   List<TypeOfService> result =
  //       await widget._requestController.getTypeOfService("");
  //   setState(() {
  //     typeofservices = result;
  //     itemsTypeOfServices.clear();
  //     itemsTypeOfServices
  //         .addAll(typeofservices.map((typeofservice) => typeofservice.name));
  //     // dropdownvalue = itemsTypeOfServices.first;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Авторизация"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 15),
            //   margin: const EdgeInsets.only(top: 15.0),
            //   child: DropdownButton<String>(
            //     value: dropdownvalue,
            //     elevation: 16,
            //     hint: Container(child: Text("Выберите категорию")),
            //     style: const TextStyle(color: Colors.deepPurple),
            //     underline: Container(
            //       height: 2,
            //       color: Colors.deepPurpleAccent,
            //     ),
            //     items: categories.map((Category category) {
            //       return DropdownMenuItem<String>(
            //         value: category.name,
            //         child: Text(category.name),
            //       );
            //     }).toList(),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         dropdownvalue = newValue ?? "";
            //       });
            //     },
            //   ),
            // ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  value: dropdownvalue,
                  isExpanded: true,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  iconSize: 24,
                  hint: Container(
                    child: Text("Выберите материал"),
                  ),
                  items: categories.map((layerMaterial) {
                    return DropdownMenuItem<String>(
                      value: layerMaterial.name,
                      child: Text(
                        layerMaterial.name,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue ?? "";
                    });
                  },
                ),
              ),
            ),

            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 15),
            //   margin: const EdgeInsets.only(top: 15.0),
            //   child: DropdownButton(
            //     value: dropdownvalue,
            //     elevation: 16,
            //     style: const TextStyle(color: Colors.deepPurple),
            //     underline: Container(
            //       height: 2,
            //       color: Colors.deepPurpleAccent,
            //     ),
            //     items: itemsTypeOfServices.map((String item) {
            //       return DropdownMenuItem(
            //         value: item,
            //         child: Text(item),
            //       );
            //     }).toList(),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         dropdownvalue = newValue!;
            //       });
            //     },
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(top: 15.0),
              child: TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 3, 5),
                      maxTime: DateTime(2024, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: LocaleType.ru);
                },
                child: Text(
                  'show date time picker (Chinese)',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(
                        userID: '',
                      ),
                    ),
                  );
                },
                child: Text(
                  'Вход',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
