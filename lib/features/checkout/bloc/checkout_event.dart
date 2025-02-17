import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String productName;
  final String price;
  final String imageUrl;
  final int quantity;

  AddToCartEvent({
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productName, price, imageUrl, quantity];
}

class UpdateCartQuantityEvent extends CartEvent {
  final String productName;
  final int quantity;

  UpdateCartQuantityEvent({
    required this.productName,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productName, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final String productName;

  RemoveFromCartEvent({required this.productName});

  @override
  List<Object?> get props => [productName];
}
