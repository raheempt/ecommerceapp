import 'package:shopify/features/model/product_model.dart';


class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
