import 'dart:convert';

import 'package:covid19/models/country_details.dart';
import 'package:covid19/services/api_services.dart';
import 'package:flutter/material.dart';

class CountryDetailsProvider with ChangeNotifier {
  var api = ApiServices();
  DetailCountry countryDetails;

  Future<DetailCountry> getCountryDetailsProvider(String id) async {
    
    final response = await api.client.get("${api.baseUrl}/api/countries/$id");
    final response2 = await api.client.get("${api.worldUrl}/countries/$id");

    if (response.statusCode == 200) {
      notifyListeners();
      var res = detailCountryFromJson(response.body);
      var res2 = json.decode(response2.body) as Map<String, dynamic>;

      countryDetails = res;
      countryDetails.flag = res2['countryInfo']['flag'] ==null ? null : res2['countryInfo']['flag'];
      print(res2['countryInfo']['flag']);
      return countryDetails;
    } else {
      return null;
    }
  }
}