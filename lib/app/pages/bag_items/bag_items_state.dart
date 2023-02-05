import 'package:dw9_delivery_app/app/models/payment_type_model.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'bag_items_state.g.dart';

@match
enum BagItemsStatus {
  initial,
  loading,
  loaded,
  updated,
  confirmRemove,
  emptyBag,
  success,
  error,
}

class BagItemsState extends Equatable {
  final BagItemsStatus status;
  final List<PaymentTypeModel> paymentTypes;
  final List<OrderProductDto> bagItems;
  final String? errorMessage;

  const BagItemsState({
    required this.status,
    required this.paymentTypes,
    required this.bagItems,
    this.errorMessage,
  });

  const BagItemsState.initial()
      : status = BagItemsStatus.initial,
        paymentTypes = const [],
        bagItems = const [],
        errorMessage = null;

  double get totalBagValue => bagItems.fold(
        0.0,
        (previousValue, item) => previousValue + item.totalPrice,
      );

  @override
  List<Object?> get props => [status, paymentTypes, bagItems, errorMessage];

  BagItemsState copyWith({
    BagItemsStatus? status,
    List<PaymentTypeModel>? paymentTypes,
    List<OrderProductDto>? bagItems,
    String? errorMessage,
  }) {
    return BagItemsState(
      status: status ?? this.status,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      bagItems: bagItems ?? this.bagItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ConfirmRemoveBagItemsState extends BagItemsState {
  final OrderProductDto orderProduct;
  final int index;

  const ConfirmRemoveBagItemsState({
    required this.index,
    required this.orderProduct,
    required super.status,
    required super.paymentTypes,
    required super.bagItems,
    super.errorMessage,
  });
}
