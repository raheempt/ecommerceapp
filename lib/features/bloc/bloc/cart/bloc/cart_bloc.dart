import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/model/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';





class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _items = [];

  CartBloc() : super(CartUpdatedState([], 0)) {
    on<AddToCartEvent>(_addToCart);
    on<IncreaseQtyEvent>(_increaseQty);
    on<DecreaseQtyEvent>(_decreaseQty);
    on<ClearCartEvent>(_clearCart);
    on<RemoveFromCartEvent>(_removeFromCart); 
  }

  void _removeFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) {
    _items.removeWhere(
      (item) => item.product.id == event.product.id,
    );

    emit(CartUpdatedState(List.from(_items), _total()));
  }

  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final index =
        _items.indexWhere((e) => e.product.id == event.product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: event.product));
    }

    emit(CartUpdatedState(List.from(_items), _total()));
  }

  void _increaseQty(IncreaseQtyEvent event, Emitter<CartState> emit) {
    final index =
        _items.indexWhere((e) => e.product.id == event.product.id);

    if (index >= 0) {
      _items[index].quantity++;
      emit(CartUpdatedState(List.from(_items), _total()));
    }
  }

  void _decreaseQty(DecreaseQtyEvent event, Emitter<CartState> emit) {
    final index =
        _items.indexWhere((e) => e.product.id == event.product.id);

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }

      emit(CartUpdatedState(List.from(_items), _total()));
    }
  }

  void _clearCart(ClearCartEvent event, Emitter<CartState> emit) {
    _items.clear();
    emit(CartUpdatedState([], 0));
  }

  double _total() {
    return _items.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}
