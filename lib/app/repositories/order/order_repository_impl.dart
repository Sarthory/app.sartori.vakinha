import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/dto/order_dto.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';
import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getPaymentTypes() async {
    try {
      final res = await dio.auth().get('/payment-types');

      final paymentTypes = res.data
          .map<PaymentTypeModel>(
            (p) => PaymentTypeModel.fromMap(p),
          )
          .toList();

      return paymentTypes;
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento.', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamento.');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      final productsMap = order.products
          .map((p) => {
                'id': p.product.id,
                'amount': p.amount,
                'total_price': p.totalPrice,
              })
          .toList();

      final postObj = {
        'products': productsMap,
        'user_id': '#userAuthRef',
        'address': order.deliveryAddress,
        'CPF': order.cpf,
        'payment_method_id': order.paymentTypeId,
      };

      await dio.auth().post('/orders', data: postObj);
    } on DioError catch (e, s) {
      log('Erro ao salvar dados da compra.', error: e, stackTrace: s);
      throw RepositoryException(
        message: 'Ocorreu um erro ao salvar dados da compra.',
      );
    }
  }
}
