import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider =
    FutureProvider.autoDispose<ConnectivityResult>((ref) async {
  final connectivity = Connectivity();
  final result = await connectivity.checkConnectivity();
  return result;
});
