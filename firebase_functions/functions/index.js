const functions = require("firebase-functions");
const axios = require("axios");
require("dotenv").config();

const admin = require('firebase-admin');
admin.initializeApp();

const baseUrl = "https://developers.zomato.com/api/v2.1";

exports.searchRestaurants = functions.https.onRequest((req, res) => {
  // search restaurant via zomato api
  const lat = req.query.lat;
  const lon = req.query.lon;
  if (lat === undefined || lon === undefined) {
    res.status(404).json({
      success: false,
      message: "Missing required params (lon/lat)"
    });
  }

  axios.get(`${baseUrl}/search`, {
    headers: {'user-key': functions.config().zomato.key},
    params: {
      lat: lat,
      lon: lon,
      sort: 'real_distance'
    }
  })
  .then((response) => {
    res.status(200).json({
      success: true,
      restaurants: response.data.restaurants
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

exports.plans = functions.https.onRequest((req, res) => {
  if (req.method === 'GET') {
    const userId = req.body.id;
    if (userId !== undefined) {
      admin
        .firestore()
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => {
          let planData = snapshot.data();
          if (planData.email != req.query.email) {
            res.status(403).json({success: false});
            return;
          }
          delete planData.email;
          res.status(200).json({success: true, ...planData});
        })
      
      return;
    }

    res.status(401).json({success: false});
    return;
  } else if (req.method === 'POST') {
    const userId = req.body.id;
    if (userId !== undefined) {
      let addedPlan = {
        planType: req.body.planType,
        planDetail: req.body.planDetail
      };
      const date = req.body.date;

      admin
        .firestore()
        .collection('users')
        .doc(userId)
        .update({
          [date]: addedPlan
        })
        .then((result) => {
          res.status(200).json({success: true});
        });

      return;
    }

    res.status(401).json({success: false});
    return;
  }

  res.status(405).json({success: false});
});

exports.setupUserDB = functions.auth.user().onCreate((user) => {
  return admin
    .firestore()
    .collection('users')
    .doc(user.uid)
    .set({'email': user.email});
});
