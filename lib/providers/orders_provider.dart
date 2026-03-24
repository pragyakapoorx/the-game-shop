import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';

class OrdersNotifier extends Notifier<List<Order>> {
  @override
  List<Order> build() => []; // Start with no orders

  void addOrder(Order order) {
    // Add the newest order to the top of the list
    state = [order, ...state];
  }
}

final ordersProvider = NotifierProvider<OrdersNotifier, List<Order>>(() {
  return OrdersNotifier();
});