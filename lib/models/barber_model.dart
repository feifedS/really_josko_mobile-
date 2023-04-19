import 'package:last/models/service_model.dart';

class Barber {
  late int user;
  late String name;
  late List<TypeOfService> services;

  Barber();
  factory Barber.fromJson(Map<String, dynamic> json) {
    List<TypeOfService> services = [];
    List<dynamic> servicesJson = json['services'];
    servicesJson.forEach((element) {
      if (element is Map<String, dynamic>) {
        TypeOfService service = TypeOfService.fromJson(element);
        services.add(service);
      }
    });
    Barber barber = Barber();
    barber.user = json['user'];
    barber.name = json['name'];
    barber.services = services;
    return barber;
  }
}
