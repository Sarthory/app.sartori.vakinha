import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/dto/order_dto.dart';
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

  void incrementProduct(int index) {
    final bagItems = [...state.bagItems];
    final orderItem = bagItems[index];
    bagItems[index] = orderItem.copyWith(amount: orderItem.amount + 1);
    emit(state.copyWith(bagItems: bagItems, status: BagItemsStatus.updated));
  }

  void decrementProduct(int index) {
    final bagItems = [...state.bagItems];
    final orderItem = bagItems[index];
    final itemAmount = orderItem.amount;

    if (itemAmount == 1) {
      if (state.status != BagItemsStatus.confirmRemove) {
        emit(
          ConfirmRemoveBagItemsState(
            index: index,
            orderProduct: orderItem,
            status: BagItemsStatus.confirmRemove,
            paymentTypes: state.paymentTypes,
            bagItems: state.bagItems,
            errorMessage: state.errorMessage,
          ),
        );

        return;
      } else {
        bagItems.removeAt(index);
      }
    } else {
      bagItems[index] = orderItem.copyWith(amount: orderItem.amount - 1);
    }

    if (bagItems.isEmpty) {
      emit(state.copyWith(status: BagItemsStatus.emptyBag));
      return;
    }

    emit(state.copyWith(bagItems: bagItems, status: BagItemsStatus.updated));
  }

  void cancelRemovalProcess() {
    emit(state.copyWith(status: BagItemsStatus.loaded));
  }

  emptyBag() {
    emit(state.copyWith(status: BagItemsStatus.emptyBag));
  }

  void saveOrder(String deliveryAddress, String cpf, int paymentTypeId) async {
    try {
      emit(state.copyWith(status: BagItemsStatus.loading));

      await _orderRepository.saveOrder(
        OrderDto(
          products: state.bagItems,
          deliveryAddress: deliveryAddress,
          cpf: cpf,
          paymentTypeId: paymentTypeId,
        ),
      );

      emit(state.copyWith(status: BagItemsStatus.success));
    } on RepositoryException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(state.copyWith(status: BagItemsStatus.error));
    }
  }
}
