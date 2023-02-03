import 'dart:developer';

import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/pages/home/home_state.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';
import 'package:bloc/bloc.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;

  HomeController(
    this._productsRepository,
  ) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));

    try {
      final products = await _productsRepository.findAllProducts();

      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch (e, s) {
      log(
        'Erro ao buscar produtos',
        error: e,
        stackTrace: s,
      );
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao buscar produtos',
        ),
      );
    }
  }

  void addOrUpdateBagItems(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];

    final productIndex =
        shoppingBag.indexWhere((o) => o.product == orderProduct.product);

    if (productIndex > -1) {
      orderProduct.amount != 0
          ? shoppingBag[productIndex] = orderProduct
          : shoppingBag.removeAt(productIndex);
    } else {
      shoppingBag.add(orderProduct);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
