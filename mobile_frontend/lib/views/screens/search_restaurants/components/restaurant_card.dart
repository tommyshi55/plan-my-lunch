import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/components/restaurant_action_modal.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final bool isInSearchResult;

  const RestaurantCard({
    Key key,
    this.restaurant,
    this.isInSearchResult = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // show modal
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: RestaurantActionModal(
                  restaurant: restaurant,
                  displayAddButton: isInSearchResult,
                ),
              );
            });
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            restaurant.thumbnail != null &&
                    restaurant.thumbnail.isNotEmpty &&
                    restaurant.thumbnail != ''
                ? Ink(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(restaurant.thumbnail),
                      ),
                    ),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    color: Colors.blueGrey,
                    child: Icon(
                      Icons.restaurant,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Wrap(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text(restaurant.locality),
                      ],
                    ),
                    SizedBox(height: 5),
                    RatingBarIndicator(
                      rating: double.parse(restaurant.rating),
                      itemBuilder: (_, __) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      itemSize: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
