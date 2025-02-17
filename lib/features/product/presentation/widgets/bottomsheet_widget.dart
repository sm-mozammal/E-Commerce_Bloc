import 'package:ecommerce_bloc/common_wigdets/common_button.dart';
import 'package:ecommerce_bloc/constants/text_font_style.dart';
import 'package:ecommerce_bloc/features/checkout/bloc/checkout_bloc.dart';
import 'package:ecommerce_bloc/features/checkout/bloc/checkout_state.dart';
import 'package:ecommerce_bloc/features/checkout/presentation/checkout_screen.dart';
import 'package:ecommerce_bloc/helpers/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BootomSheetwidget extends StatelessWidget {
  const BootomSheetwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height(13),
      decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state is CartLoadedState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "মোট:",
                        style: TextFontStyle.textStyle16Roboto,
                      ),
                      Text(
                        "৳${state.totalPrice}",
                        style: TextFontStyle.textStyle16Roboto,
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            }),
            CommonButton(
                width: SizeConfig.width(80),
                height: SizeConfig.height(5),
                text: "Order Now",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CheckoutPopup(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
