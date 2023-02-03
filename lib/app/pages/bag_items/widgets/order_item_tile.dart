import 'package:dw9_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final int index;
  final OrderProductDto? orderProduct;

  const OrderItemTile({
    super.key,
    required this.index,
    required this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Image.network(
            'https://assets.unileversolutions.com/recipes-v2/106684.jpg?imwidth=800',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'X-Burger',
                  style: context.textStyles.textMedium.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      r"R$19,90",
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 14,
                        color: ColorsApp.i.secondary,
                      ),
                    ),
                    DeliveryIncrementDecrementButton.compact(
                      amount: 1,
                      incrementTap: () {},
                      decrementTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
