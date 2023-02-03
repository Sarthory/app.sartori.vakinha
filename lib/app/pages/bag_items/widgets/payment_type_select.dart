import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

class PaymentTypeSelect extends StatelessWidget {
  final List<PaymentTypeModel> paymentTypes;
  final ValueChanged<int> valueChanged;
  final String selectedValue;
  final bool valid;

  const PaymentTypeSelect({
    super.key,
    required this.paymentTypes,
    required this.valueChanged,
    required this.selectedValue,
    required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartSelect<String>.single(
            title: 'Forma de pagamento',
            selectedValue: selectedValue,
            modalType: S2ModalType.bottomSheet,
            onChange: (selected) {
              valueChanged(int.parse(selected.value));
            },
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: context.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selected.title ?? 'Forma de pagamento',
                            style: context.textStyles.textMedium.copyWith(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Colors.red[900], thickness: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            child: Text(
                              "Selecione uma forma de pagamento",
                              style: context.textStyles.textRegular.copyWith(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom<String, Map<String, String>>(
              source: paymentTypes
                  .map(
                    (paymentType) => {
                      'value': '${paymentType.id}',
                      'title': paymentType.name,
                    },
                  )
                  .toList(),
              title: (index, item) => "💸 Pagamento 👉 ${item['title']}",
              value: (index, item) => item['value'] ?? '',
              group: (index, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
          ),
        ],
      ),
    );
  }
}
