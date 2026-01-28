import 'package:shopify/features/model/cart_item.dart';


abstract class CartState {}

class CartUpdatedState extends CartState {
  final List<CartItem> items;
  final double totalPrice;

  CartUpdatedState(this.items, this.totalPrice);
}
