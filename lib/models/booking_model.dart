import 'package:last/models/barber_model.dart';
import 'package:last/models/service_model.dart';

import 'api_models.dart';
import 'barber_model.dart';

class Booking {
  late int id;
  late String date;
  late String time;
  late String barber;
  late int customer;
  late String service;
  Booking();
  factory Booking.fromJson(Map<String, dynamic> json) {
    List<Barber> barbers = [];
    List<dynamic> barberJson = json['barber'];
    barberJson.forEach((element) {
      if (element is Map<String, dynamic>) {
        Barber barber = Barber.fromJson(element);
        barbers.add(barber);
      }
    });
    List<TypeOfService> services = [];
    List<dynamic> servicesJson = json['services'];
    servicesJson.forEach((element) {
      if (element is Map<String, dynamic>) {
        TypeOfService service = TypeOfService.fromJson(element);
        services.add(service);
      }
    });
    Booking booking = Booking();
    booking.id = json['id'];
    booking.date = json['date'];
    booking.time = json['time'];
    booking.barber = json['barber'];
    booking.service = json['service'];
    // booking.barber = barbers;
    // booking.service = services;
    return booking;
  }

  Booking.sendbooking(
    Token token,
    this.date,
    this.barber,
  );
  Map<String, dynamic> toOrderJson() => {
        'type_of_service': this.date,
        'times_pick': this.barber,
      };
}
