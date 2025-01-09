import 'package:flutter/material.dart';

class Locationtile extends StatelessWidget {
  final String location;
  const Locationtile({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset('assets/Detailspage/location-icon.png'),
          const SizedBox(
            width: 7,
          ),
          Expanded(child: Text(location)),
        ],
      ),
    );
  }
}
