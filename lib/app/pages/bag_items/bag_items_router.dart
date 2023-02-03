import 'package:dw9_delivery_app/app/pages/bag_items/bag_items_controller.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/bag_items_page.dart';
import 'package:dw9_delivery_app/app/repositories/order/order_repository.dart';
import 'package:dw9_delivery_app/app/repositories/order/order_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagItemsRouter {
  BagItemsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(dio: context.read()),
          ),
          Provider<BagItemsController>(
            create: (context) => BagItemsController(context.read()),
          ),
        ],
        child: const BagItemsPage(),
      );
}
