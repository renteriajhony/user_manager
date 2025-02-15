import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_namager/domain/repositories/address_repository.dart';
import 'package:user_namager/domain/usecases/get_list_address_use_case.dart';
import '../../data/datasources/local_data_source.dart';
import '../../data/repositories/address_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../usecases/get_list_user_use_case.dart';
import '../usecases/usecases.dart';

// Provider para la base de datos local
final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  return LocalDataSource();
});

// Provider del repositorio usando la implementación concreta
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return UserRepositoryImpl(localDataSource);
});

// Provider del caso de uso CreateUserUseCase
final createUserUseCaseProvider = Provider<CreateUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return CreateUserUseCase(repository);
});

// Provider del caso de uso GetUserUseCase
final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUseCase(repository);
});

// Provider del caso de uso GetListUserUseCase
final getListUserUseCaseProvider = Provider<GetListUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetListUserUseCase(repository);
});


// Provider del repositorio usando la implementación concreta
final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return AddressRepositoryImpl(localDataSource);
});

// Provider del caso de uso GetListAddressUseCase
final getListAddresUseCaseProvider = Provider<GetListAddressUseCase>((ref) {
  final repository = ref.watch(addressRepositoryProvider);
  return GetListAddressUseCase(repository);
});