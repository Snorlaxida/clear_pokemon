import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivityMain;
  late final StreamSubscription<dynamic> connectivityStream;

  InternetCubit({required Connectivity connectivity})
      : connectivityMain = connectivity,
        super(InternetState()) {
    connectivityStream = connectivityMain.onConnectivityChanged
        .listen((List<ConnectivityResult> res) {
      if (res.contains(ConnectivityResult.wifi)) {
        emit(InternetState(type: InternetTypes.connected));
      } else if (res.contains(ConnectivityResult.none)) {
        emit(InternetState(type: InternetTypes.offline));
      } else {
        emit(InternetState());
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStream.cancel();
    return super.close();
  }
}
