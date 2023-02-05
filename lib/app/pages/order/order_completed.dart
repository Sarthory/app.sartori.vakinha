import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompleted extends StatelessWidget {
  const OrderCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: context.percentHeight(.20),
                ),
                Image.asset('assets/images/logo_rounded.png'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Pedido realizado com sucesso!\nEm breve você receberá a confirmação do seu pedido!\nObrigado!',
                    textAlign: TextAlign.center,
                    style: context.textStyles.textExtraBold.copyWith(
                        color: Color.fromARGB(255, 15, 69, 88), fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                ),
                DeliveryButton(
                  label: 'FECHAR',
                  height: 60,
                  width: double.infinity,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
