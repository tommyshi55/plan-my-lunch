import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_frontend/business_logic/services/restaurant_service.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/components/restaurant_card.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String searchStatus;
  double lat = 36;
  double lon = -120;

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
            onPressed: () async {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              setState(() {
                searchStatus = 'start';
                lat = position.latitude;
                lon = position.longitude;
              });
            },
            width: size.width * 0.95,
            color: kPrimaryLightColor,
            textColor: Colors.black,
          ),
          RoundedButton(
            text: 'Search',
            onPressed: () {
              setState(() {
                searchStatus = 'start';
              });
            },
            width: size.width * 0.95,
            verticalMargin: 0,
          ),
          searchStatus != null
              ? FutureBuilder(
                  future: RestaurantService().searchRestaurants(37.0, -122.0),
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView(
                          children: snapshot.data
                              .map<Widget>((restaurant) =>
                                  RestaurantCard(restaurant: restaurant))
                              .toList(),
                        ),
                      );
                    }

                    return Text('Error');
                  },
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black12,
                        size: 150,
                      ),
                      Text(
                        'No results to display',
                        style: TextStyle(
                          color: Colors.black12,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
