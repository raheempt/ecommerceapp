
import 'package:shopify/features/model/product_model.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<ProductModel> products;
  final String selectedCategory;

  HomeLoadedState(this.products, this.selectedCategory);
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}
