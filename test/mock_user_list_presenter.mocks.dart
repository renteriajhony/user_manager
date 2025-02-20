// Mocks generated by Mockito 5.4.5 from annotations
// in user_namager/test/mock_user_list_presenter.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_riverpod/flutter_riverpod.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i6;
import 'package:user_namager/domain/entities/user.dart' as _i5;
import 'package:user_namager/presentation/presenters/user_list_presenter.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [UserListPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserListPresenter extends _i1.Mock implements _i2.UserListPresenter {
  MockUserListPresenter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isLoading =>
      (super.noSuchMethod(Invocation.getter(#isLoading), returnValue: false)
          as bool);

  @override
  set isLoading(bool? _isLoading) => super.noSuchMethod(
    Invocation.setter(#isLoading, _isLoading),
    returnValueForMissingStub: null,
  );

  @override
  set onError(_i3.ErrorListener? _onError) => super.noSuchMethod(
    Invocation.setter(#onError, _onError),
    returnValueForMissingStub: null,
  );

  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);

  @override
  _i4.Stream<List<_i5.User>?> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i4.Stream<List<_i5.User>?>.empty(),
          )
          as _i4.Stream<List<_i5.User>?>);

  @override
  set state(List<_i5.User>? value) => super.noSuchMethod(
    Invocation.setter(#state, value),
    returnValueForMissingStub: null,
  );

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i4.Future<bool> loadListUser() =>
      (super.noSuchMethod(
            Invocation.method(#loadListUser, []),
            returnValue: _i4.Future<bool>.value(false),
          )
          as _i4.Future<bool>);

  @override
  bool updateShouldNotify(List<_i5.User>? old, List<_i5.User>? current) =>
      (super.noSuchMethod(
            Invocation.method(#updateShouldNotify, [old, current]),
            returnValue: false,
          )
          as bool);

  @override
  _i3.RemoveListener addListener(
    _i6.Listener<List<_i5.User>?>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #addListener,
              [listener],
              {#fireImmediately: fireImmediately},
            ),
            returnValue: () {},
          )
          as _i3.RemoveListener);

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );
}
