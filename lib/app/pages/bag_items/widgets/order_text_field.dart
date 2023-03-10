import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String placeholder;

  const OrderTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: context.textStyles.textMedium.copyWith(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: placeholder,
              border: defaultBorder,
              enabledBorder: defaultBorder,
              focusedBorder: defaultBorder,
            ),
          ),
        ],
      ),
    );
  }
}
