import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/presentation/presenters/address_list_presenter.dart';
import '../../domain/entities/address.dart';
import '../../domain/providers/usecase_providers.dart';


final addressListProvider =
    StateNotifierProvider<AddressListPresenter, AddressListState>((ref) {
  final getListAddressUseCase = ref.watch(getListAddresUseCaseProvider);
  return AddressListPresenter(getListAddressUseCase);
});

// Método para cargar un lista de direcciones desde la base de datos
final loadAddressListProvider = Provider((ref) {
  return (String id) {
    return ref.read(addressListProvider.notifier).loadListAddressUser(id);
  };
});

// Método para agregar una dirección en memoria a un usuario
final addCurrentAddressListProvider = Provider((ref) {
  return (Address address) {
    return ref.read(addressListProvider.notifier).addCurrentAddress(address);
  };
});
