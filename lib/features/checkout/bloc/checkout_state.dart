import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String productName;
  final String price;
  final String imageUrl;
  final int quantity;

  const CartItem({
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      productName: productName,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [productName, price, imageUrl, quantity];
}

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItem> cartItems;

  CartLoadedState({this.cartItems = const []});

  double get totalPrice => cartItems.fold(
        0.0,
        (sum, item) => sum + (double.parse(item.price) * item.quantity),
      );

  @override
  List<Object?> get props => [cartItems];
}
