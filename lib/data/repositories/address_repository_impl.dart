import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';
import '../datasources/local_data_source.dart';

class AddressRepositoryImpl implements AddressRepository {
  final LocalDataSource _localDataSource;

  AddressRepositoryImpl(this._localDataSource);

  @override
  Future<List<Address>> getAddresUser(String id) async {
    return await _localDataSource.getUserAddresses(id);
  }

  @override
  Future<void> addListAddress(List<Address> address, String userId) {
    return _localDataSource.insertListAddress(address, userId);
  }
}
