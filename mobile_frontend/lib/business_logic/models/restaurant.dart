class Restaurant {
  final String id;
  final String name;
  final String address;
  final String locality;
  final String rating;
  final int reviews;
  final String thumbnail;
  final String url;

  Restaurant(this.id, this.name, this.address, this.locality, this.rating,
      this.reviews, this.thumbnail, this.url);

  Map<String, String> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "locality": locality,
      "rating": rating,
      "reviews": reviews.toString(),
      "thumbnail": thumbnail,
      "url": url
    };
  }

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        locality = json['locality'],
        rating = json['rating'],
        reviews = json['reviews'],
        thumbnail = json['thumbnail'],
        url = json['url'];
}
