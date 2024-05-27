import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/location_picker/location_picker/domain/model/location_model.dart';

abstract class ILocationFacade {
  Future<bool> getLocationPermisson();
  Future<Either<MainFailure, PlaceMark?>> getCurrentLocationAddress();

  FutureResult<List<PlaceMark>?> getSearchPlaces(String query);

  Future<Either<MainFailure, Unit>> setLocationByLaboratory(
      PlaceMark placeMark);

  Future<Either<MainFailure, Unit>> updateUserLocation(
      PlaceMark placeMark, String userId);
}
