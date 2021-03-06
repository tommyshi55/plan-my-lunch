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
    admin
      .firestore()
      .collection('users')
      .where('email', '==', req.query.email)
      .get()
      .then((snapshot) => {
        let planData = snapshot.docs[0].data();
        if (planData.email != req.query.email) {
          res.status(403).json({success: false});
          return;
        }
        delete planData.email;
        if (req.query.date === undefined) {
          res.status(200).json({success: true, ...planData});
          return;
        }
        const planOnDate = planData[req.query.date];
        res.status(200).json({success: true, ...planOnDate});
      })
    return;
  } else if (req.method === 'POST') {
    const userId = req.body.id;
    if (userId !== undefined) {
      let addedPlan = {
        planType: req.body.planType
      };
      if (req.body.planDetail) {
        addedPlan['planDetail'] = req.body.planDetail
      }
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
        })
        .catch(err => {
          res.status(500).json({success: false});
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
