// // import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class DeterminePosition {
//   currentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Geolocator.openLocationSettings();
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permantly denied, we cannot request permissions.');
//     }

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         return Future.error(
//             'Location permissions are denied (actual value: $permission).');
//       }
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     Placemark place = placemarks[0];
//     String placeName =
//         "${place.subLocality},${place.locality}, ${place.country}";
//     return placeName;
//   }
// }
