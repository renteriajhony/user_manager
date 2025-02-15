import 'package:user_namager/domain/entities/address.dart';
import 'package:user_namager/domain/repositories/address_repository.dart';

class GetListAddressUseCase {
  final AddressRepository repository;

  GetListAddressUseCase(this.repository);

  Future<void> addListAddress(List<Address> address, String userId) async {
    return repository.addListAddress(address, userId);
  }

  Future<List<Address>> getAddressByUser(String id) async {
    return repository.getAddresUser(id);
  }
}
