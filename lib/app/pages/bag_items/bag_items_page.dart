import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/widgets/order_item_tile.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/widgets/order_text_field.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/widgets/payment_type_select.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class BagItemsPage extends StatelessWidget {
  const BagItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sacola',
                        style: context.textStyles.textTitle,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          size: 30,
                          Icons.delete_forever_outlined,
                          color: Colors.red[300],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
              (context, index) {
                return Column(
                  children: [
                    OrderItemTile(
                      index: index,
                      orderProduct: OrderProductDto(
                        product: ProductModel(
                          id: 1,
                          name: '1',
                          image: '1',
                          price: 12.0,
                          description: '1',
                        ),
                        amount: 2,
                      ),
                    ),
                    Divider(color: Colors.grey)
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "💲Total do pedido 👉",
                        style: context.textStyles.textExtraBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        r"R$50,00",
                        style: context.textStyles.textExtraBold.copyWith(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                OrderTextField(
                  title: 'Endereço de Entrega',
                  controller: TextEditingController(),
                  validator: Validatorless.required('m'),
                  placeholder: 'Digite o endereço que receberá os produtos',
                ),
                SizedBox(
                  height: 20,
                ),
                OrderTextField(
                  title: 'CPF',
                  controller: TextEditingController(),
                  validator: Validatorless.required('m'),
                  placeholder: 'Digite o CPF',
                ),
                const SizedBox(
                  height: 10,
                ),
                PaymentTypeSelect(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DeliveryButton(
                    label: 'FECHAR PEDIDO',
                    width: double.infinity,
                    height: 48,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
