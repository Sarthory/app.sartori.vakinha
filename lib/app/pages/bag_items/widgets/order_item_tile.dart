import 'package:dw9_delivery_app/app/core/extensions/formatter_extension.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final int index;
  final OrderProductDto bagItem;

  const OrderItemTile({
    super.key,
    required this.index,
    required this.bagItem,
  });

  @override
  Widget build(BuildContext context) {
    final product = bagItem.product;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
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
                      (bagItem.amount * product.price).toCurrencyPTBR,
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 14,
                        color: ColorsApp.i.secondary,
                      ),
                    ),
                    DeliveryIncrementDecrementButton.compact(
                      amount: bagItem.amount,
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
