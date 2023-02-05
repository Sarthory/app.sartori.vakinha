import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> _navigatorKey;

  static GlobalContext? _instance;

  GlobalContext._();

  static GlobalContext get i {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  Future<void> loginExpired() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();

    showTopSnackBar(
      _navigatorKey.currentState!.overlay!,
      CustomSnackBar.error(
        message: 'Login expirado, por favor, faça login novamente.',
        backgroundColor: Colors.orange[400]!,
      ),
    );

    _navigatorKey.currentState!.popUntil(ModalRoute.withName('/home'));
  }
}
