// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bag_items_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension BagItemsStatusMatch on BagItemsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == BagItemsStatus.initial) {
      return initial();
    }

    if (v == BagItemsStatus.loading) {
      return loading();
    }

    if (v == BagItemsStatus.loaded) {
      return loaded();
    }

    if (v == BagItemsStatus.error) {
      return error();
    }

    throw Exception('BagItemsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == BagItemsStatus.initial && initial != null) {
      return initial();
    }

    if (v == BagItemsStatus.loading && loading != null) {
      return loading();
    }

    if (v == BagItemsStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == BagItemsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
