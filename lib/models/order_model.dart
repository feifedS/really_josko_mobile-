import 'package:last/models/api_models.dart';

class sendBooking {
  late Token token;
  late String type_of_service;
  late String barber;
  late String date;
  late String time;

  sendBooking();
  sendBooking.sendorder(
    Token token,
    this.type_of_service,
    this.barber,
    this.date,
    this.time,
  );
  Map<String, dynamic> toOrderJson() => {
        'type_of_service': this.type_of_service,
        'barber': this.barber,
        'date': this.date,
        'time': this.time,
      };
}
