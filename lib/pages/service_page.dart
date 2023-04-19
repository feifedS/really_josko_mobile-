import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:last/controllers/home_controller.dart';
import 'package:last/controllers/request_controller.dart';
import 'package:last/models/api_models.dart';
import 'package:last/models/category_model.dart';
import 'package:last/pages/register_page.dart';
import 'package:last/pages/reset_password.dart';
import 'package:last/services/storage_service.dart';
import '../models/barber_model.dart';
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
  TextEditingController dateController = TextEditingController();
  final StorageService _storageService = StorageService();
  String selectedDate = "";
  TextEditingController typeofserviceController = TextEditingController();
  TextEditingController timespickController = TextEditingController();
  String? dropdownvalue;
  String? typeofservicesvalue;
  String? barbersvalue;
  String? timesvalue;
  late String barber;
  late String timesPick = '';
  List<String> itemsCategories = [];
  List<String> itemsTypeOfServices = [];
  List<String> itemsBarbers = [];
  List<String> avaliableTimes = [];

  late List<Category> categories = [];
  List<TypeOfService> typeofservices = [];
  late List<Barber> barbers = [];

  String typeofserviceselected = '';
  String barberselected = '';
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
      loadBarbers();
    });
  }

  Future<void> loadtimes() async {
    // Clear the available times list
    // Set the selected time to null
    setState(() {
      timesvalue = null;
      timesvalue = avaliableTimes.isNotEmpty ? avaliableTimes.first : null;
    });
  }
  // Future<void> loadtimes() async {
  //   // Clear the available times list
  //   setState(() {
  //     avaliableTimes.clear();
  //     timesvalue = null;
  //   });

  //   // Load the available times for the selected date
  //   final times = await widget._requestController.getBooking(
  //     '',
  //     barber,
  //     timesPick,
  //   );
  //   setState(() {
  //     avaliableTimes = times;
  //     timesvalue = avaliableTimes.isNotEmpty ? avaliableTimes.first : null;
  //   });
  // }

  // Future<void> loadBarbers() async {
  //   List<Barber> result =
  //       await widget._requestController.getBarber(typeofservicesvalue ?? '');

  //   // await widget._requestController.getBarber('');
  //   setState(() {
  //     barbers = result
  //         .where((barber) => barber.services
  //             .any((service) => service.name == typeofservicesvalue))
  //         .toList();

  //     barbersvalue = itemsBarbers.isNotEmpty ? itemsBarbers.first : null;
  //   });
  // }
  Future<void> loadBarbers() async {
    List<Barber> result =
        await widget._requestController.getBarber(typeofservicesvalue ?? '');

    // await widget._requestController.getBarber('');
    setState(() {
      barbers = result
          .where((barber) => barber.services
              .any((service) => service.name == typeofservicesvalue))
          .toList();

      barbersvalue = itemsBarbers.isNotEmpty ? itemsBarbers.first : null;
    });
  }

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
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(
                top: 15.0,
              ),
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(
                top: 15.0,
              ),
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
                    setState(() {
                      if (newValue != null) {
                        typeofserviceselected = newValue;
                      }
                      print("PPPPPPPPPPPPPPPPPP$typeofserviceselected");
                      typeofservicesvalue = newValue ?? "";
                      loadBarbers();
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  value: barbersvalue,
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
                    ...itemsBarbers
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
                    ...barbers.map((layerMaterial) {
                      return DropdownMenuItem<String>(
                        value: layerMaterial.name,
                        child: Text(
                          layerMaterial.name,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      barberselected = newValue;
                    }
                    if (timesPick != '') {
                      barber = barberselected;

                      var times = await widget._requestController.getBooking(
                        '',
                        barber,
                        timesPick,
                      );
                      timesvalue = null;
                      dynamic time = times;
                      avaliableTimes = times;
                    }
                    setState(() {
                      if (newValue != null) {
                        barberselected = newValue;
                      }
                      // print("PPPPPPPPPPPPPPPPPP$selected");
                      barbersvalue = newValue ?? "";
                    });
                  },
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: const EdgeInsets.only(top: 15.0, left: 1),
                    child: TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime.now().add(Duration(days: 21)),
                            onChanged: (date) async {},
                            onConfirm: (date) async {
                          timesPick = DateFormat('dd.MM.yyyy').format(date);
                          barber = barberselected;
                          var times =
                              await widget._requestController.getBooking(
                            '',
                            barber,
                            timesPick,
                          );
                          setState(() {
                            timesvalue = null;
                            dynamic time = times;
                            avaliableTimes = times;
                            selectedDate =
                                DateFormat('yyyy-MM-dd').format(date);
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.ru);
                      },
                      child: Text(
                        'Выберите дату оказания услуги: ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.5,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                if (selectedDate != null)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        ' $selectedDate',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0),
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.5,
                          // decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  value: timesvalue,
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
                    ...avaliableTimes.map((layerMaterial) {
                      return DropdownMenuItem<String>(
                        value: layerMaterial,
                        child: Text(
                          layerMaterial,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue != null) {
                        timesvalue = newValue;
                      }
                      print("PPPPPPPPPPPPPPPPPP$timesvalue");
                      timesvalue = newValue ?? "";
                    });
                  },
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
                  String? type_of_service = typeofservicesvalue;

                  String date = timesPick;
                  String? time = timesvalue;
                  bool success =
                      await widget._requestController.bookingController(
                    '',
                    type_of_service!,
                    barber,
                    date,
                    time!,
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
                  'Заказать',
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
