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

  RequestController _requestController = RequestController();
}

class _ServiceState extends State<ServicePage> {
  final StorageService _storageService = StorageService();
  String selectedDate = "";
  TextEditingController typeofserviceController = TextEditingController();
  TextEditingController timespickController = TextEditingController();
  String? dropdownvalue;
  String? typeofservicesvalue;
  List<String> itemsCategories = [];
  List<String> itemsTypeOfServices = [];
  late List<Category> categories = [];
  List<TypeOfService> typeofservices = [];

  String selected = '';
  // String selectedDate = '';
  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    List<Category> result = await widget._requestController.getCategory('');
    setState(() {
      categories = result;
      // dropdownvalue = categories.isNotEmpty ? categories.first.name : null;
      loadTypeOfServices();
    });
  }

  Future<void> loadTypeOfServices() async {
    List<TypeOfService> result =
        await widget._requestController.getTypeOfService(dropdownvalue ?? '');
    setState(() {
      typeofservices = result
          .where((service) => service.category.name == dropdownvalue)
          .toList();
      typeofservicesvalue =
          itemsTypeOfServices.isNotEmpty ? itemsTypeOfServices.first : null;
    });
  }

  // void updateTypeOfServices() async {
  //   List<TypeOfService> result =
  //       await widget._requestController.getTypeOfService(dropdownvalue ?? '');
  //   setState(() {
  //     typeofservices = result
  //         .where((service) => service.category.name == dropdownvalue)
  //         .toList();
  //     typeofservicesvalue =
  //         typeofservices.isNotEmpty ? typeofservices.first.name : null;
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
                  hint: Text("Выберите категорию"),
                  items: [
                    const DropdownMenuItem<String>(
                      value: "",
                      enabled: false,
                      child: Text(
                        "Выберите категорию",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    ...categories.map((layerMaterial) {
                      return DropdownMenuItem<String>(
                        value: layerMaterial.name,
                        child: Text(
                          layerMaterial.name,
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue ?? "";
                      loadTypeOfServices();
                    });
                  },
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  value: typeofservicesvalue,
                  isExpanded: true,
                  isDense: true,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    // color: Colors.blue,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  iconSize: 24,
                  hint: Text("Услуга"),
                  items: [
                    ...itemsTypeOfServices
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    ...typeofservices.map((layerMaterial) {
                      return DropdownMenuItem<String>(
                        value: layerMaterial.name,
                        child: Text(
                          layerMaterial.name,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selected = newValue;
                    }
                    print("PPPPPPPPPPPPPPPPPP$selected");
                    setState(() {
                      typeofservicesvalue = newValue ?? "";
                    });
                  },
                ),
              ),
            ),
// class _ServiceState extends State<ServicePage> {
//   final StorageService _storageService = StorageService();
//   String selectedDate = "";

//   String? dropdownvalue;
//   String? typeofservicesvalue;
//   List<String> itemsCategories = [];
//   List<String> itemsTypeOfServices = [];
//   late List<Category> categories = [];
//   List<TypeOfService> typeofservices = [];
//   @override
//   void initState() {
//     super.initState();
//     loadCategories();
//     // loadTypeOfServices();
//   }

//   Future<void> loadCategories() async {
//     List<Category> result = await widget._requestController.getCategory(
//       '',
//     );
//     setState(() {
//       categories = result;
//       print("QQQQQQQQQQQQQQQQQQQQQQ ${categories.first.name}");
//       // itemsCategories.clear();
//       // itemsCategories.addAll(categories.map((category) => category.name));
//       // dropdownvalue = itemsCategories.first;
//     });
//   }

//   Future<void> loadTypeOfServices() async {
//     List<TypeOfService> result =
//         await widget._requestController.getTypeOfService("");
//     setState(() {
//       typeofservices = result;
//       // itemsTypeOfServices.clear();
//       // itemsTypeOfServices
//       //     .addAll(typeofservices.map((typeofservice) => typeofservice.name));
//       // dropdownvalue = itemsTypeOfServices.first;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Авторизация"),
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[

//             Container(
//               child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: DropdownButton<String>(
//                   value: dropdownvalue,
//                   isExpanded: true,
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                   icon: Icon(Icons.arrow_drop_down),
//                   underline: Container(
//                     height: 2,
//                     color: Colors.blue,
//                   ),
//                   iconSize: 24,
//                   hint: Container(
//                     child: Text("Выберите материал"),
//                   ),
//                   items: categories.map((layerMaterial) {
//                     return DropdownMenuItem<String>(
//                       value: layerMaterial.name,
//                       child: Text(
//                         layerMaterial.name,
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     );
//                   }).toList(),
//                   // Step 5.
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       dropdownvalue = newValue ?? "";
//                     });
//                   },
//                 ),
//               ),
//             ),
//             Container(
//               child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: DropdownButton<String>(
//                   value: typeofservicesvalue,
//                   isExpanded: true,
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                   icon: Icon(Icons.arrow_drop_down),
//                   underline: Container(
//                     height: 2,
//                     color: Colors.blue,
//                   ),
//                   iconSize: 24,
//                   hint: Container(
//                     child: Text("Выберите материал"),
//                   ),
//                   items: typeofservices.map((layerMaterial) {
//                     return DropdownMenuItem<String>(
//                       value: layerMaterial.name,
//                       child: Text(
//                         layerMaterial.name,
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     );
//                   }).toList(),
//                   // Step 5.
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       typeofservicesvalue = newValue ?? "";
//                     });
//                   },
//                 ),
//               ),
//             ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(top: 15.0),
              child: TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2025, 12, 31),
                      onChanged: (date) async {},
                      //   onChanged: (date) {
                      //   print('change $date');
                      // },
                      onConfirm: (date) {
                    print('confirm $date');

                    selectedDate =
                        "${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}:${date.second}";
                    print("ooooooooooooooooo$selectedDate");
                  }, currentTime: DateTime.now(), locale: LocaleType.kh);
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
                  String type_of_service = selectedDate;
                  String times_pick = selected;
                  bool success =
                      await widget._requestController.orderController(
                    '',
                    type_of_service,
                    times_pick,
                  );
                  if (success == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(
                          userID: '',
                        ),
                      ),
                    );
                  } else {}
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
