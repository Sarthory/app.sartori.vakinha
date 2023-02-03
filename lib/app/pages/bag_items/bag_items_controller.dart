import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/bag_items_state.dart';
import 'package:dw9_delivery_app/app/repositories/order/order_repository.dart';

class BagItemsController extends Cubit<BagItemsState> {
  final OrderRepository _orderRepository;

  BagItemsController(this._orderRepository) : super(BagItemsState.initial());

  Future<void> loadItems(List<OrderProductDto> bagItems) async {
    try {
      emit(state.copyWith(status: BagItemsStatus.loading));

      final paymentTypes = await _orderRepository.getPaymentTypes();

      emit(state.copyWith(
        status: BagItemsStatus.loaded,
        paymentTypes: paymentTypes,
        bagItems: bagItems,
      ));
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(status: BagItemsStatus.error));
    }
  }
}
