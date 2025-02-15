import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/domain/entities/address.dart';

class LitstAddress extends ConsumerWidget {
  const LitstAddress({super.key, required this.listAddress});

  final List<Address> listAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ...listAddress.map(
          (item) => RichText(
            text: TextSpan(
              text: 'Direccion: ',
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.primary),
              children: [
                TextSpan(
                  text: '${item.street}, ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: '${item.city}, ${item.country} \n',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
