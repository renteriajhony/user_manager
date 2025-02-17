import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_namager/domain/entities/address.dart';
import 'package:user_namager/domain/usecases/get_list_address_use_case.dart';
import 'package:user_namager/presentation/presenters/address_list_presenter.dart';

class MockGetListAddressUseCase extends Mock implements GetListAddressUseCase {}

void main() {
  late MockGetListAddressUseCase mockGetListAddressUseCase;
  late AddressListPresenter addressListPresenter;

  setUp(() {
    mockGetListAddressUseCase = MockGetListAddressUseCase();
    addressListPresenter = AddressListPresenter(mockGetListAddressUseCase);
  });

  test('Estado inicial, lista vacia', () {
    expect(addressListPresenter.state.addresses, []);
    expect(addressListPresenter.state.currentAddress, null);
  });

 

  test('addCurrentAddress should add address to the list', () {
    final address = Address(city: '1', street: 'Street 1', country: 'Country');

    addressListPresenter.addCurrentAddress(address);

    expect(addressListPresenter.state.addresses, [address]);
  });

  test('addCurrentListAddress should replace the addresses list', () {
    final addresses = [
      Address(city: '1', street: 'Street 1', country: 'Country'),
      Address(city: '2', street: 'Street 2', country: 'Country')
    ];

    addressListPresenter.addCurrentListAddress(addresses);

    expect(addressListPresenter.state.addresses, addresses);
  });

  test('editCurrentAddress should update currentAddress', () {
    final address = Address(city: '1', street: 'Street 1', country: 'Country');

    addressListPresenter.editCurrentAddress(address);

    expect(addressListPresenter.state.currentAddress, address);
  });

 

  test('resetCurrentAddressState should reset the state', () {
    addressListPresenter.resetCurrentAddressState();

    expect(addressListPresenter.state.addresses, []);
    expect(addressListPresenter.state.currentAddress, null);
  });
}
