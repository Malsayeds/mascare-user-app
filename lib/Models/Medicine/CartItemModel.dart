
class CartItemModel{
  int medicine_id;
  double price;
  int quantity;
  CartItemModel({
    required this.medicine_id,
    required this.price,
    required this.quantity
  });
  Map<String, dynamic> toJson() => {
    "medicine_id": medicine_id,
    "price": price,
    "quantity": quantity,
  };
}