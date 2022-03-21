import 'dart:convert';

import 'package:covid19/models/worldwide_model.dart';
import 'package:covid19/services/api_services.dart';
import 'package:flutter/material.dart';



class WorldwideProvider with ChangeNotifier {
  var api = ApiServices();
  WorldWideModel worldWide = new WorldWideModel();

  Future<WorldWideModel> getWorldWideProvider() async {

    final response = await api.client.get("${api.worldUrl}/all");
    final response2 = await api.client.get("${api.baseUrl}/api");
    
    if (response.statusCode == 200 && response2.statusCode == 200) {
      notifyListeners();
      var res = json.decode(response.body) as Map<String, dynamic>;
      var res2 = json.decode(response2.body) as Map<String, dynamic>;

      worldWide.confirmed = res['cases'] == null ? null : res['cases'];
      worldWide.deaths = res['deaths'] == null ? null : res['deaths'];
      worldWide.recovered = res['recovered'] == null ? null : res['recovered'];
      worldWide.lastUpdate = res2['lastUpdate']== null ? null : DateTime.parse(res2['lastUpdate']);
      return worldWide;
    } else {
      return null;
    }
  }
}