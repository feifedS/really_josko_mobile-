import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:last/pages/login_page.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:last/repository/user_repository.dart';
import 'package:last/controllers/home_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();

  final HomeController _homeController = HomeController();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedDate = "";
  String? _character = "Мужчина";
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Регистрация"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 50.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  controller: firstnameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white)),
                    labelText: 'Ваше имя',
                    hintText: 'Введите ваше имя',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 50.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  controller: lastnameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white)),
                    labelText: 'Ваша фамилия',
                    hintText: 'Введите вашу фамилию',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 50.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Придумайте имя пользователя',
                    hintText: 'Введите имя пользователя',
                  ),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Radio<String?>(
                                value: "Женщина",
                                groupValue: _character,
                                onChanged: (String? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text('Женщина'),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              Radio<String?>(
                                value: "Мужчина",
                                groupValue: _character,
                                onChanged: (String? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text('Мужчина'),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ]),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 50.0),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Телефон',
                    hintText: 'Введите телефон',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Введите почту',
                        hintText:
                            'Введите настоящую почту  (пример:abc@gmail.com)'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Необходимо"),
                      EmailValidator(errorText: "Введите настоящую почту"),
                    ])),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(top: 15.0),
                  child: CalendarDatePicker(
                    firstDate: DateTime(1970, 1, 1),
                    lastDate: DateTime(2025, 1, 1),
                    currentDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    onDateChanged: (DateTime value) async {
                      selectedDate = value.toString().substring(0, 10);
                    },
                  )),
              Container(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: password1Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Придумайте пароль',
                      hintText: 'Введите ваш пароль'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    MinLengthValidator(9,
                        errorText: "Password should be atleast 9 characters"),
                    MaxLengthValidator(15,
                        errorText:
                            "Password should not be greater than 15 characters")
                  ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: password2Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Повторите ввод пароля',
                      hintText: 'Введите ваш пароль'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    MinLengthValidator(9,
                        errorText: "Password should be atleast 9 characters"),
                    MaxLengthValidator(15,
                        errorText:
                            "Password should not be greater than 15 characters")
                  ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String firstname = firstnameController.text;
                    String lastname = lastnameController.text;
                    String email = emailController.text;
                    String password1 = password1Controller.text;
                    String password2 = password2Controller.text;
                    String genderId = '1';
                    String phoneNumber = phoneNumberController.text;

                    bool success = await widget._homeController.registerUser(
                      username,
                      firstname,
                      lastname,
                      email,
                      password1,
                      password2,
                      selectedDate,
                      genderId,
                      phoneNumber,
                    );

                    if (success == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginDemo()));
                    } else {}
                  },
                  child: Text(
                    'Зарегистрироваться',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
