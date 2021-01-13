import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/components/restaurant_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            onTap: () async {},
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Enter the address',
              border: OutlineInputBorder(),
              filled: true,
              errorStyle: TextStyle(fontSize: 15),
            ),
          ),
          RoundedButton(
            text: 'Use Current Location',
            onPressed: () {},
            width: size.width * 0.95,
            color: kPrimaryLightColor,
            textColor: Colors.black,
          ),
          RoundedButton(
            text: 'Search',
            onPressed: () {},
            width: size.width * 0.95,
            verticalMargin: 0,
          ),
          Expanded(
            child: ListView(
              children: [
                RestaurantCard(),
                RestaurantCard(),
                RestaurantCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// Expanded(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Icon(
//         Icons.search,
//         color: Colors.black12,
//         size: 150,
//       ),
//       Text(
//         'No results to display',
//         style: TextStyle(
//           color: Colors.black12,
//           fontSize: 25,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   ),
// ),
