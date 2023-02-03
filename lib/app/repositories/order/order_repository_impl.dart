import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
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
}
