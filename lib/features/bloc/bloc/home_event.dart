abstract class HomeEvent {}

class FetchProductsEvent extends HomeEvent {}

class FilterByCategoryEvent extends HomeEvent {
  final String category;
  FilterByCategoryEvent(this.category);
}
