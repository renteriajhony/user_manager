import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_namager/presentation/pages/widgets/address_widget.dart';
import 'package:user_namager/presentation/providers/addres_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../presenters/address_list_presenter.dart';
import '../providers/user_provider.dart';

class UserFormPage extends ConsumerWidget {
  UserFormPage({super.key, required this.idUser});

  final String idUser;

  static final formUserKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _birthdayFocusNode = FocusNode();

  bool flagUpdate = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressListState = ref.watch(addressListProvider);
    if (idUser.trim().isNotEmpty && !flagUpdate) {
      final user = ref.read(userPresenterProvider.notifier).loadUser(idUser);
      user.then((onValue) {
        _nameController.text = onValue?.name ?? '';
        _lastNameController.text = onValue?.lastName ?? '';
        _birthdayController.text = DateFormat('yyyy-MM-dd')
            .format(onValue?.birthDate ?? DateTime.now());

        ref
            .read(addressListProvider.notifier)
            .addCurrentListAddress(onValue?.addresses ?? []);

        ref.invalidate(userPresenterProvider);
        flagUpdate = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: idUser.trim().isEmpty
            ? Text('Crear Usuario')
            : Text('Actualizar Usuario'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            ref.read(addressListProvider.notifier).resetCurrentAddressState();
            context.go('/');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save_as_outlined),
            onPressed: () {
              saveUser(context, ref, idUser, addressListState);
            },
          ),
        ],
      ),
      body: Form(
        key: formUserKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                key: Key('user_txt_name'),
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Nombre es requerido' : null,
              ),
              TextFormField(
                key: Key('user_txt_lastname'),
                controller: _lastNameController,
                focusNode: _lastNameFocusNode,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) =>
                    value!.isEmpty ? 'Apellido es requerido' : null,
              ),
              TextFormField(
                key: Key('user_txt_birtday'),
                controller: _birthdayController,
                focusNode: _birthdayFocusNode,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: "Fecha de nacimiento",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor selecciona una fecha valida";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AddressWidget(),
              ),
              Expanded(
                child: ListView.builder(
                  key: Key('list_address_user'),
                  padding: EdgeInsets.symmetric(vertical: 50),
                  itemCount: addressListState.addresses.length,
                  itemBuilder: (context, index) {
                    final address = addressListState.addresses[index];
                    final uuid = Uuid().v4();
                    return Card(
                      child: Dismissible(
                        key: Key('delete-$uuid'),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.blue,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            ref
                                .read(addressListProvider.notifier)
                                .removeCurrentAddress(index);
                          } else if (direction == DismissDirection.endToStart) {
                            ref
                                .read(addressListProvider.notifier)
                                .editCurrentAddress(address);
                            ref
                                .read(addressListProvider.notifier)
                                .removeCurrentAddress(index);
                          }
                        },
                        child: ListTile(
                          title: Text(address.street),
                          subtitle: Text('${address.city}, ${address.country}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime startDate = DateTime.now().subtract(Duration(days: 1));
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1900),
      lastDate: startDate,
      // locale: const Locale("es", "ES"),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      _birthdayController.text = formattedDate;
    }
  }

  saveUser(
    BuildContext context,
    WidgetRef ref,
    String userId,
    AddressListState addressListState,
  ) async {
    bool isValiadUserForm = formUserKey.currentState?.validate() ?? false;
    bool existAddress = addressListState.addresses.isNotEmpty;
    bool isValiadAddressForm = false;

    if (!isValiadUserForm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Datos del usuario incompletos',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 800),
        ),
      );
      return;
    }

    if (!isValiadUserForm && !existAddress) {
      isValiadAddressForm =
          AddressWidget.formAddressKey.currentState?.validate() ?? false;
      if (!isValiadAddressForm) {
        return;
      }
    }

    if (isValiadUserForm && !existAddress) {
      isValiadAddressForm =
          AddressWidget.formAddressKey.currentState?.validate() ?? false;
      if (!isValiadAddressForm || !existAddress) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Debes agregar almenos una direccion',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(milliseconds: 800),
          ),
        );
        return;
      }
    }
    if (userId.trim().isEmpty) userId = Uuid().v4();
    await ref.read(userPresenterProvider.notifier).setUserState(
          userId,
          _nameController.text,
          _lastNameController.text,
          _birthdayController.text,
          addressListState.addresses,
        );
    bool isSaved = await ref.read(userPresenterProvider.notifier).saveUser(ref);
    if (!context.mounted) return;
    if (isSaved) {
      ref.read(addressListProvider.notifier).resetCurrentAddressState();
      _nameController.clear();
      _lastNameController.clear();
      _birthdayController.clear();
      _nameFocusNode.unfocus();
      _lastNameFocusNode.unfocus();
      _birthdayFocusNode.unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Usuario Agregado',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.greenAccent,
          duration: Duration(milliseconds: 800),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ocurrio un error al guardar el usuario',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 800),
        ),
      );
    }
  }
}
