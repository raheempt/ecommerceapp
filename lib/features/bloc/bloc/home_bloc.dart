import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shopify/features/model/product_model.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ProductModel> allProducts = [];

  HomeBloc() : super(HomeLoadingState()) {
    on<FetchProductsEvent>(_fetchProducts);
    on<FilterByCategoryEvent>(_filterProducts);
  }

  Future<void> _fetchProducts(
      FetchProductsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      final List data = jsonDecode(response.body);
      allProducts = data.map((e) => ProductModel.fromJson(e)).toList();

      emit(HomeLoadedState(allProducts, 'All'));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  void _filterProducts(
      FilterByCategoryEvent event, Emitter<HomeState> emit) {
    if (event.category == 'All') {
      emit(HomeLoadedState(allProducts, 'All'));
    } else {
      final filtered = allProducts
          .where((p) => p.category.contains(event.category.toLowerCase()))
          .toList();

      emit(HomeLoadedState(filtered, event.category));
    }
  }
}
