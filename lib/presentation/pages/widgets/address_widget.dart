import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/presentation/providers/addres_provider.dart';

import '../../../domain/entities/address.dart';

class AddressWidget extends ConsumerWidget {
  static final formAddressKey = GlobalKey<FormState>();
  AddressWidget({
    super.key,
    this.street = '',
    this.city = '',
    this.country = '',
  });

  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();

  final String? street;
  final String? city;
  final String? country;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressListState = ref.watch(addressListProvider);

    if (addressListState.currentAddress != null) {
      _streetController.text = addressListState.currentAddress?.street ?? '';
      _cityController.text = addressListState.currentAddress?.city ?? '';
      _countryController.text = addressListState.currentAddress?.country ?? '';
    }

    return Form(
      key: AddressWidget.formAddressKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Direccion'),
          TextFormField(
            focusNode: _streetFocusNode,
            controller: _streetController,
            decoration: InputDecoration(labelText: 'Calle'),
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: _cityFocusNode,
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'Ciudad'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo requerido' : null,
                ),
              ),
              Text(','),
              Expanded(
                child: TextFormField(
                  focusNode: _countryFocusNode,
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'País'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo requerido' : null,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (AddressWidget.formAddressKey.currentState!.validate()) {
                    final address = Address(
                      street: _streetController.text,
                      city: _cityController.text,
                      country: _countryController.text,
                    );

                    ref
                        .read(addressListProvider.notifier)
                        .addCurrentAddress(address);

                    formAddressKey.currentState!.reset();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Direccion Agregada',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.greenAccent,
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _streetController.dispose();
  //   _cityController.dispose();
  //   _countryController.dispose();
  // }
}
