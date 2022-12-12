import 'dart:async';

import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessLocation extends StatefulWidget {
  final CameraPosition? storePosition;
  const BusinessLocation({Key? key, this.storePosition}) : super(key: key);

  @override
  State<BusinessLocation> createState() => _BusinessLocationState();
}

class _BusinessLocationState extends State<BusinessLocation> {
  late GoogleMapController _mapController;
  CameraPosition? currentLocation;
  CameraPosition? savedLocation;
  bool currentLocationClicked = false;

  Future<void> onMapCreated(GoogleMapController controller) async {
    setState(() {
      _mapController = controller;
    });
  }

  @override
  void initState() {
    initializeLocation();
    super.initState();
  }

  initializeLocation() async {
    if (widget.storePosition == null) {
      Position? currentPosition = await getCurrentPosition(context);
      if (currentPosition != null) {
        savedLocation = CameraPosition(
          target: LatLng(
            currentPosition.latitude,
            currentPosition.longitude,
          ),
          zoom: 14.4746,
        );
      }
    } else {
      savedLocation = widget.storePosition;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    saveStoreLocation() {
      Navigator.pop(
        context,
        currentLocation,
      );
    }

    getCurrentLocation() async {
      showLoaderDialog(context);

      Position? position = await getCurrentPosition(context);
      if (position != null) {
        setState(() {
          currentLocation = CameraPosition(
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
            zoom: 14.4746,
          );
          currentLocationClicked = true;
        });
        _mapController.moveCamera(CameraUpdate.newCameraPosition(
          currentLocation!,
        ));
        _mapController.showMarkerInfoWindow(
          const MarkerId('current_location'),
        );
      } else {
        print('position is null');
      }
      Navigator.pop(context);
    }

    Future<List<Uint8List>> getMarkersIcons() async {
      return [
        await getBytesFromAsset('assets/icons/focus_location.png', 150),
        await getBytesFromAsset('assets/icons/pin_location.png', 150),
      ];
    }

    return FutureBuilder<List<Uint8List>>(
      future: getMarkersIcons(),
      builder: (context, markerIcon) {
        return Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.background,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: savedLocation != null
                    ? GoogleMap(
                        mapType: MapType.normal,
                        zoomControlsEnabled: true,
                        buildingsEnabled: false,
                        indoorViewEnabled: false,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        padding: EdgeInsets.only(
                          bottom: rSize(60),
                          left: isRtl(context) ? 0 : rSize(30),
                          right: isRtl(context) ? rSize(30) : 0,
                        ),
                        initialCameraPosition: savedLocation!,
                        markers: markerIcon.hasData
                            ? {
                                currentLocation != null
                                    ? Marker(
                                        icon: BitmapDescriptor.fromBytes(
                                          markerIcon.data![0],
                                        ),
                                        markerId:
                                            const MarkerId('current_location'),
                                        infoWindow: InfoWindow(
                                          title: Languages.of(context)!
                                              .currentLocationLabel,
                                        ),
                                        position: LatLng(
                                          currentLocation!.target.latitude,
                                          currentLocation!.target.longitude,
                                        ),
                                      )
                                    : const Marker(
                                        markerId: MarkerId('current_location'),
                                      ),
                                Marker(
                                  icon: BitmapDescriptor.fromBytes(
                                      markerIcon.data![1]),
                                  markerId: const MarkerId('store_location'),
                                  infoWindow: InfoWindow(
                                    title: Languages.of(context)!
                                        .currentLocationLabel,
                                  ),
                                  position: LatLng(
                                    savedLocation!.target.latitude,
                                    savedLocation!.target.longitude,
                                  ),
                                ),
                              }
                            : {},
                        onMapCreated: onMapCreated,
                      )
                    : Center(
                        child: CustomLoadingIndicator(
                          customLoadingIndicatorProps:
                              CustomLoadingIndicatorProps(),
                        ),
                      ),
              ),
            ),
            Positioned(
              top: rSize(60),
              left: isRtl(context) ? null : rSize(30),
              right: isRtl(context) ? rSize(30) : null,
              child: CustomIcon(
                customIconProps: CustomIconProps(
                  icon: Icon(
                    Icons.arrow_back,
                    size: rSize(25),
                  ),
                  isDisabled: false,
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ),
            Positioned(
              bottom: rSize(60),
              right: rSize(30),
              left: rSize(30),
              child: Column(
                children: [
                  CustomButton(
                    customButtonProps: CustomButtonProps(
                      onTap: () => getCurrentLocation(),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      text: 'Go to current location',
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: currentLocationClicked
                        ? Padding(
                            padding: EdgeInsets.only(top: rSize(10)),
                            child: CustomButton(
                              customButtonProps: CustomButtonProps(
                                onTap: () => saveStoreLocation(),
                                text: 'save store location',
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
