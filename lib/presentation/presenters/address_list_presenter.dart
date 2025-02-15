import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/address.dart';
import '../../domain/usecases/get_list_address_use_case.dart';

class AddressListState {
  final List<Address> addresses;
  Address? currentAddress;

  AddressListState({
    required this.addresses,
    this.currentAddress,
  });
}

class AddressListPresenter extends StateNotifier<AddressListState> {
  final GetListAddressUseCase _getListAddressUseCase;

  AddressListPresenter(this._getListAddressUseCase)
      : super(AddressListState(addresses: []));

  // Método para cargar la lista de direcciones de un usuario
  Future<void> loadListAddressUser(String userId) async {
    state = AddressListState(addresses: state.addresses);

    final List<Address> listAddress =
        await _getListAddressUseCase.getAddressByUser(userId);

    state = AddressListState(addresses: listAddress);
  }

  /// Método para guardar una lista de direcciones
  Future<void> createListAddress(List<Address> address, String userId) async {
    await _getListAddressUseCase.addListAddress(address, userId);
    state = AddressListState(addresses: address, currentAddress: null);
  }

  void addCurrentAddress(Address address) {
    final updatedList = [...state.addresses, address];
    state = AddressListState(addresses: updatedList);
  }

  void addCurrentListAddress(List<Address> addresses) {
    state = AddressListState(addresses: addresses);
  }

  void editCurrentAddress(Address address) {
    state = AddressListState(
      addresses: state.addresses,
      currentAddress: address,
    );
  }

  void removeCurrentAddress(int index) {
    final updatedList = state.addresses;
    updatedList.removeAt(index);
    state = AddressListState(
      addresses: updatedList,
      currentAddress: state.currentAddress,
    );
  }

  void resetCurrentAddressState() {
    state = AddressListState(
      addresses: [],
      currentAddress: null,
    );
  }
}
