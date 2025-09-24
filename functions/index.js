const functions = require("firebase-functions");
const axios = require("axios");

// ⚡ функция для поиска отелей Booking через RapidAPI
exports.searchHotels = functions.https.onCall(async (data, context) => {
  try {
    const options = {
      method: 'GET',
      url: 'https://booking-com.p.rapidapi.com/v1/hotels/search',
      params: {
        checkout_date: '2025-09-20',   // дата выезда
        checkin_date: '2025-09-15',    // дата заезда
        units: 'metric',
        adults_number: '2',
        order_by: 'popularity',
        dest_id: '-2601889',           // Лондон (Booking dest_id)
        dest_type: 'city',
        locale: 'en-gb',
        currency: 'GBP'
      },
      headers: {
        'x-rapidapi-host': 'booking-com.p.rapidapi.com',
        'x-rapidapi-key': 'ТВОЙ_API_KEY'   // вставь сюда свой ключ
      }
    };

    const response = await axios.request(options);
    return response.data;
  } catch (error) {
    console.error(error.response?.data || error.message);
    throw new functions.https.HttpsError(
      "unknown",
      "Booking API error",
      error.response?.data || error.message
    );
  }
});
