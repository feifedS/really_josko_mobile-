import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
// import 'package:flutter_session/flutter_session.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:last/models/api_models.dart';
import 'package:last/models/barber_model.dart';
import 'package:last/models/booking_model.dart';
import 'package:last/models/category_model.dart';
import 'package:last/models/service_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:last/api_connection/api_connection.dart';
import 'package:last/repository/request_interface.dart';

import '../models/order_model.dart';

class RequestRepository implements IRequestRepository {
  @override
  Future<List<Category>> getCategory(Token token) async {
    return await getCategories(token);
  }

  @override
  Future<List<TypeOfService>> getTypeOfService(Token token) async {
    return await getTypeOfServices(token);
  }

  @override
  Future<List<Barber>> getBarber(Token token) async {
    return await getBarbers(token);
  }

  // Future<List<String>> getBarberTimes(
  //     Token token, String barber, String times_pick) async {
  //   return await getTimes(token);
  // }

  @override
  Future<bool> booking(
    Token token,
    String type_of_service,
    String barber,
    String date,
    String time,
  ) async {
    sendBooking orderSendModel = sendBooking.sendorder(
      token,
      type_of_service,
      barber,
      date,
      time,
    );
    Future<bool> success = bookingAPI(orderSendModel, token);

    print("FFFFFFFFFFF: ${success}");

    return success;
  }

  Future<List<String>> getBooking(
      Token token, String barber, String date) async {
    Booking bookingSendModel = Booking.sendbooking(
      token,
      barber,
      date,
    );
    Future<List<String>> times = getBookingsAPI(bookingSendModel, token);
    return times;
  }

  // @override
  // Future<bool> order(String type_of_service, String times_pick) async {
  //   Order orderSendModel = Order.sendorder(
  //     type_of_service,
  //     times_pick,
  //   );
  //   Future<bool> success = orderApi(orderSendModel);

  //   return success;
  // }
}
