import 'package:dw9_delivery_app/app/core/extensions/formatter_extension.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBagButton extends StatelessWidget {
  final List<OrderProductDto> shoppingBag;

  const ShoppingBagButton({
    super.key,
    required this.shoppingBag,
  });

  Future<void> _goToOrders(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sharedPrefs = await SharedPreferences.getInstance();
    var hasToken = sharedPrefs.containsKey('accessToken');
    //sharedPrefs.clear();

    if (!hasToken) {
      final loginResult = await navigator.pushNamed('/login');
      if (loginResult == null || loginResult == false) {
        return;
      }
    }

    final currentBagItems = await navigator.pushNamed(
      '/bagItems',
      arguments: shoppingBag,
    );

    controller.updateBagItems(currentBagItems as List<OrderProductDto>);
  }

  @override
  Widget build(BuildContext context) {
    var totalBagValue = shoppingBag.fold(
      0.0,
      (previousValue, element) => previousValue += element.totalPrice,
    );

    return Container(
      padding: EdgeInsets.all(20),
      width: context.screenWidth,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black26,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          _goToOrders(context);
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_bag_outlined),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Ver Sacola",
                style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBagValue.toCurrencyPTBR,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
