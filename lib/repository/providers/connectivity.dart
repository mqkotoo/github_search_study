import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider =
    Provider.autoDispose<Connectivity>((ref) => Connectivity());
