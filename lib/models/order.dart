class Order {
  final String id;
  final String date;
  final List<int> gameIds;
  final double total;
  final String payMethod;
  final String email;
  final String? promo;

  const Order({
    required this.id,
    required this.date,
    required this.gameIds,
    required this.total,
    required this.payMethod,
    required this.email,
    this.promo,
  });
}