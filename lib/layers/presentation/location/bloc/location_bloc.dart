import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<GetLocationEvent>(_getLocation);
    on<CheckInitialConnection>(_checkInitialConnection);
    on<CheckConnectionEvent>(_handleConnectivityChange);

    // Start listening to changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((_) {
      add(CheckConnectionEvent()); // no data passed
    });
  }
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
    bool _hasRequestedLocation = false; // 

  Future<void> _checkInitialConnection(
      CheckInitialConnection event, Emitter<LocationState> emit) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.loading));
    await _emitCurrentConnectionStatus(emit);
  }

  Future<void> _handleConnectivityChange(
      CheckConnectionEvent event, Emitter<LocationState> emit) async {
    await _emitCurrentConnectionStatus(emit);
  }

  Future<void> _emitCurrentConnectionStatus(Emitter<LocationState> emit) async {
    try {
      final result = await _connectivity.checkConnectivity();

      final isConnected = result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi);

      if (isConnected) {
        emit(state.copyWith(
          connectionStatus: ConnectionStatus.connected,
          result: result,
        ));

        // ✅ Trigger GetLocationEvent only ONCE
        if (!_hasRequestedLocation) {
          _hasRequestedLocation = true;
          add(GetLocationEvent());
        }
      } else {
        emit(state.copyWith(
          connectionStatus: ConnectionStatus.disconnected,
          result: result,
        ));
      }
    } catch (_) {
      emit(state.copyWith(connectionStatus: ConnectionStatus.disconnected));
    }
  }

  FutureOr<void> _getLocation(event, Emitter<LocationState> emit) async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      //   return emit(state.copyWith(
      //       status: LocationStatus.error,
      //       errorMessege: 'Location services are disabled.'));
      // }
      print("hiiiiii");

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return emit(state.copyWith(
              status: LocationStatus.error,
              errorMessege: 'Location permissions are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return emit(state.copyWith(
            status: LocationStatus.error,
            errorMessege:
                'Location permissions are permanently denied, we cannot request permissions.'));
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      emit(state.copyWith(
          status: LocationStatus.loaded,
          latitude: position.latitude,
          longitude: position.longitude));
    } catch (e) {
      emit(state.copyWith(
          status: LocationStatus.error, errorMessege: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
