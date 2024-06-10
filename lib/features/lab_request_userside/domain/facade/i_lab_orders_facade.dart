import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/models/lab_orders_model.dart';

abstract class ILabOrdersFacade {
  FutureResult<List<LabOrdersModel>> getLabOrders({required String labId});
  FutureResult<String> setDeliveryCharge(
      {required String orderId, required num charge});
}
