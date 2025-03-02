import 'package:ecommerce_bloc/features/checkout/bloc/checkout_event.dart';
import 'package:ecommerce_bloc/features/checkout/bloc/checkout_state.dart';
import 'package:ecommerce_bloc/helpers/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateCartQuantityEvent>(_onUpdateCartQuantity);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final currentState = state;

    if (currentState is CartLoadedState) {
      final cartItems = List<CartItem>.from(currentState.cartItems);
      final index =
          cartItems.indexWhere((item) => item.productName == event.productName);

      // if (int.parse(event.stockQuantity) > event.quantity) {
      if (index == -1) {
        cartItems.add(
          CartItem(
            stockQuantity: event.stockQuantity,
            productName: event.productName,
            price: event.price,
            imageUrl: event.imageUrl,
            quantity: event.quantity,
          ),
        );
      } else {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity + event.quantity,
        );
      }
      // }
      // else {
      //   ToastUtil.showLongToast('Out of Stock');
      // }

      emit(CartLoadedState(cartItems: cartItems));
    } else {
      emit(
        CartLoadedState(
          cartItems: [
            CartItem(
              stockQuantity: event.stockQuantity,
              productName: event.productName,
              price: event.price,
              imageUrl: event.imageUrl,
              quantity: event.quantity,
            ),
          ],
        ),
      );
    }
  }

  void _onUpdateCartQuantity(
      UpdateCartQuantityEvent event, Emitter<CartState> emit) {
    final currentState = state;

    if (currentState is CartLoadedState) {
      final cartItems = List<CartItem>.from(currentState.cartItems);
      final index =
          cartItems.indexWhere((item) => item.productName == event.productName);

      // if (int.parse(event.stockQuantity) > event.quantity) {
      if (index != -1) {
        if (event.quantity == 0) {
          cartItems.removeAt(index);
        } else if (event.stockQuantity == event.quantity.toString()) {
          ToastUtil.showLongToast('Out of Stock');
        } else {
          cartItems[index] =
              cartItems[index].copyWith(quantity: event.quantity);
        }
        // } else {
        //   ToastUtil.showLongToast('Out of Stock');
        // }

        emit(CartLoadedState(cartItems: cartItems));
      }
    }
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final currentState = state;

    if (currentState is CartLoadedState) {
      final cartItems = currentState.cartItems
          .where((item) => item.productName != event.productName)
          .toList();

      emit(CartLoadedState(cartItems: cartItems));
    }
  }
}
