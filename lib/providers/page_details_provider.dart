
import 'package:covid19/models/country_details.dart';
import 'package:flutter/material.dart';

class PageDetailsProvider with ChangeNotifier{

  String _contrySelected;
  DetailCountry countryDetailsModel;

  void setCountrySelected(String countrySelected){
        notifyListeners();
    _contrySelected = countrySelected;
  }

  void setCountryDeatailsModel(DetailCountry object){
        notifyListeners();
    countryDetailsModel = object;
  }

  DetailCountry getCountryDetailsModel(){
    return countryDetailsModel;
  }
  String getcontrySelected(){
    return _contrySelected;
  }

}