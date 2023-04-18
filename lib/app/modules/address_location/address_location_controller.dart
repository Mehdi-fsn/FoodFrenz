import 'package:foodfrenz/app/data/models/address_model.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_repository.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class AddressLocationController extends GetxController {
  final AddressLocationRepository addressLocationRepository;

  AddressLocationController({required this.addressLocationRepository});

  final String userId = Get.find<AuthenticationController>().user!.uid;

  final Rx<AddressModel> addressModel = AddressModel().obs;

  /*bool _loading = false;
  late Position _position;
  late Position _pickedPosition;*/

  @override
  void onReady() async {
    super.onReady();
    addressModel.value =
        await addressLocationRepository.getAddressLocation('userId');
  }

  Future<Placemark> getPlaceMark(Location location) async {
    List<Placemark> listPlacemark =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    return listPlacemark[0];
  }
}
