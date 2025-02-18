import 'package:ecommerce_bloc/common_wigdets/common_button.dart';
import 'package:ecommerce_bloc/constants/app_colors.dart';
import 'package:ecommerce_bloc/constants/text_font_style.dart';
import 'package:ecommerce_bloc/features/checkout/bloc/checkout_bloc.dart';
import 'package:ecommerce_bloc/features/checkout/bloc/checkout_state.dart';
import 'package:ecommerce_bloc/helpers/navigation_service.dart';
import 'package:ecommerce_bloc/helpers/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPopup extends StatefulWidget {
  const CheckoutPopup({super.key});

  @override
  State<CheckoutPopup> createState() => _CheckoutPopupState();
}

class _CheckoutPopupState extends State<CheckoutPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartLoadedState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "চেকআউট নিশ্চিত করুন",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(thickness: 1),
                  ...state.cartItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ProductTitleWidget(
                        item: item,
                      ),
                    );
                  }),
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "মোট",
                          style: TextFontStyle.textStyle16Roboto,
                        ),
                        Text(
                          "৳${state.totalPrice}",
                          style: TextFontStyle.textStyle16Roboto,
                        ),
                      ],
                    ),
                  ),
                  _buildButton(),
                ],
              );
            }
            return const Text('No CheckOut Found');
          }),
        ),
      ),
    );
  }

  Row _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonButton(
          text: "বাতিল",
          onPressed: () {
            NavigationService.goBack;
          },
          width: SizeConfig.width(30),
          style: TextFontStyle.textStyle12Roboto
              .copyWith(color: AppColors.cFFFFFF),
        ),
        SizedBox(width: 8),
        CommonButton(
          text: "নিশ্চিত করুন",
          onPressed: () {
            NavigationService.goBack;
          },
          width: SizeConfig.width(30),
          style: TextFontStyle.textStyle12Roboto
              .copyWith(color: AppColors.cFFFFFF),
        )
      ],
    );
  }
}

class ProductTitleWidget extends StatelessWidget {
  final CartItem item;
  const ProductTitleWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${item.productName} (৳${item.price} * ${item.quantity})',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Text(
          (double.parse(item.price) * item.quantity).toStringAsFixed(2),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
