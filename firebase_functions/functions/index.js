const functions = require("firebase-functions");
const axios = require("axios");
require("dotenv").config();

const baseUrl = "https://developers.zomato.com/api/v2.1";

exports.searchRestaurants = functions.https.onRequest((req, res) => {
  // search restaurant via zomato api
  const lat = req.query.lat;
  const lon = req.query.lon;
  axios.get(`${baseUrl}/search`, {
    headers: {'user-key': process.env.ZOMATO_API_KEY},
    params: {
      lat: lat,
      lon: lon,
      sort: 'real_distance'
    }
  })
  .then((response) => {
    // TODO: Format the data to be more meaningful 
    res.status(200).json({
      success: true,
      response: response.data
    });
  })
  .catch((err) => {
    console.log(err);
    res.status(500).json({
      success: false,
      message: 'Error fetching Zomato API'
    });
  });
});