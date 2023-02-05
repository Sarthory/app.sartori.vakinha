import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';

class OrderDto {
  List<OrderProductDto> products;
  String deliveryAddress;
  String cpf;
  int paymentTypeId;

  OrderDto({
    required this.products,
    required this.deliveryAddress,
    required this.cpf,
    required this.paymentTypeId,
  });
}
