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
  final String stockQuantity;

  AddToCartEvent({
    required this.stockQuantity,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  List<Object?> get props =>
      [productName, price, imageUrl, quantity, stockQuantity];
}

class UpdateCartQuantityEvent extends CartEvent {
  final String productName;
  final int quantity;
  final String stockQuantity;

  UpdateCartQuantityEvent({
    required this.stockQuantity,
    required this.productName,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productName, quantity, stockQuantity];
}

class RemoveFromCartEvent extends CartEvent {
  final String productName;

  RemoveFromCartEvent({required this.productName});

  @override
  List<Object?> get props => [productName];
}
