const functions = require("firebase-functions");
const axios = require("axios");
require("dotenv").config();

const baseUrl = "https://developers.zomato.com/api/v2.1";

exports.searchRestaurants = functions.https.onRequest((req, res) => {
  // search restaurant via zomato api
  axios.get(`${baseUrl}/search`, {
    headers: {'user-key': process.env.ZOMATO_API_KEY}
  })
  .then((response) => {
    res.status(200).json({
      message: response.data
    });
  })
  .catch((err) => {
    res.status(500).json({
      message: 'Error fetching Zomato API'
    });
  });
});