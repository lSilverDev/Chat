import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const addMessage = functions.https.onRequest(async (req, res) => {
  admin.initializeApp(functions.config().firebase);
  const userfcm = await admin.firestore().collection("users").doc("blblbl").get();
  const userdata = userfcm.data();
  if (!userdata) return;
  const fcm = userdata.fcm;
  const dataNtification = { data: { info: "" } };
  admin
  .messaging()
  .sendToDevice(fcm, dataNtification)
  .then(function (response: any) {
    console.log("Success");
    res.status(200).send();
  })
  .catch(function (error: any) {
    console.log("nao Success");
    res.status(666).send();
  })
  .then(() => {
      console.log("Retornando true");
      return;
    });
    console.log("Nao deveria estar aqui");
});
