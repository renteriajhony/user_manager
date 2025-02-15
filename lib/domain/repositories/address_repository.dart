import '../entities/address.dart';

abstract class AddressRepository {
  Future<List<Address>> getAddresUser(String id);
  Future<void> addListAddress(List<Address> address, String userId);
}
