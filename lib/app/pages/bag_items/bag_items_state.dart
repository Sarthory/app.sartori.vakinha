// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';

part 'bag_items_state.g.dart';

@match
enum BagItemsStatus {
  initial,
  loading,
  loaded,
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
