import 'package:meta/meta.dart';



class WorldWideModel {
  int confirmed;
  int recovered;
  int deaths;
  DateTime lastUpdate;

  WorldWideModel({
     this.confirmed,
     this.recovered,
     this.deaths,
     this.lastUpdate,
  });

}
