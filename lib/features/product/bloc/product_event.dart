import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductFetchEvent extends ProductEvent {
  const ProductFetchEvent();

  @override
  List<Object?> get props => [];
}

class ProductSearchEvent extends ProductEvent {
  final String queary;
  const ProductSearchEvent(this.queary);

  @override
  List<Object?> get props => [queary];
}
