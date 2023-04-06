import 'package:last/models/api_models.dart';

class Order {
  late String type_of_service;
  late String times_pick;
  late Token token;
  Order();
  Order.sendorder(
    Token token,
    this.type_of_service,
    this.times_pick,
  );
  Map<String, dynamic> toOrderJson() => {
        'type_of_service': this.type_of_service,
        'times_pick': this.times_pick,
      };
}
