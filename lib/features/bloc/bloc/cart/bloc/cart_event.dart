
import 'package:shopify/features/model/product_model.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  AddToCartEvent(this.product);
}

class IncreaseQtyEvent extends CartEvent {
  final ProductModel product;
  IncreaseQtyEvent(this.product);
}

class DecreaseQtyEvent extends CartEvent {
  final ProductModel product;
  DecreaseQtyEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final ProductModel product;
  RemoveFromCartEvent(this.product);
}



class ClearCartEvent extends CartEvent {}
