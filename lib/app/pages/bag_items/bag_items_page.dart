import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/bag_items_controller.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/bag_items_state.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/widgets/order_item_tile.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/widgets/order_text_field.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/widgets/payment_type_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class BagItemsPage extends StatefulWidget {
  const BagItemsPage({super.key});

  @override
  State<BagItemsPage> createState() => _BagItemsPageState();
}

class _BagItemsPageState extends BaseState<BagItemsPage, BagItemsController> {
  final _formKey = GlobalKey<FormState>();
  final _addressEC = TextEditingController();
  final _cpfEC = TextEditingController();
  final validPaymentType = ValueNotifier<bool>(true);
  int? paymentTypeId;

  @override
  void onReady() {
    controller.loadItems(
      ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BagItemsController, BagItemsState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          loaded: () => hideLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage ?? "Erro descohecido.");
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
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
              BlocSelector<BagItemsController, BagItemsState,
                  List<OrderProductDto>>(
                selector: (state) => state.bagItems,
                builder: (context, bagItems) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: bagItems.length,
                      (context, index) {
                        final bagItem = bagItems[index];

                        return Column(
                          children: [
                            OrderItemTile(
                              index: index,
                              bagItem: bagItem,
                            ),
                            Divider(color: Colors.grey)
                          ],
                        );
                      },
                    ),
                  );
                },
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
                      controller: _addressEC,
                      validator: Validatorless.required(
                        'O endereço de recebimento é obrigatório',
                      ),
                      placeholder: 'Digite o endereço que receberá os produtos',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    OrderTextField(
                      title: 'CPF',
                      controller: _cpfEC,
                      validator: Validatorless.required(
                        'É necessário informar um CPF válido',
                      ),
                      placeholder: 'Digite o CPF',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocSelector<BagItemsController, BagItemsState,
                        List<PaymentTypeModel>>(
                      selector: (state) => state.paymentTypes,
                      builder: (context, paymentTypes) {
                        return ValueListenableBuilder(
                          valueListenable: validPaymentType,
                          builder: (
                            context,
                            validPaymentTypeValue,
                            child,
                          ) {
                            return PaymentTypeSelect(
                              paymentTypes: paymentTypes,
                              valueChanged: (value) => paymentTypeId = value,
                              valid: validPaymentTypeValue,
                              selectedValue: paymentTypeId.toString(),
                            );
                          },
                        );
                      },
                    ),
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
                        onPressed: () {
                          var val = _formKey.currentState?.validate() ?? false;
                          var paymentTypeSelected = paymentTypeId != null;
                          validPaymentType.value = paymentTypeSelected;

                          if (val && paymentTypeSelected) {
                            //bang
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
