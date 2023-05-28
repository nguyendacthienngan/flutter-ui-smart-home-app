import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_home/src/domain/entities/quote_entity.dart';
import 'package:flutter_smart_home/src/domain/usecases/get_random_movie_quote.dart';
import 'package:provider/provider.dart';

class GlobalProvider extends ChangeNotifier {
  static const fireBaseUri = "/CNM/";
  final GetRandomMovieQuote getRandomMovieQuote;
  int temperatureData = 0;
  int humidityData = 0;
  int buzzerData = 0;
  int lightControl = 0;
  int lightMotion = 0;
  int motion = 0;
  int fanControl = 0;
  int soilData = 0;
  int trigger = 0;


  GlobalProvider({required this.getRandomMovieQuote});

  QuoteEntity randomQuote = QuoteEntity.empty();

  Future<void> getMovieQuote() async {
    try {
      var quote = await getRandomMovieQuote.execute();
      randomQuote = quote.foldRight(QuoteEntity.empty(), (r, previous) => r);
      notifyListeners();
    } catch (err) {
      print(err.toString());
      notifyListeners();
    }
  }

  void getSensorData() {
    getValueRef("Hoang/", "Temperature");
    // getValueRef("Humidity");
    // getValueRef("Buzzer");
    getValueRef("Hoang/", "LightControl");
    // getValueRef("LightMotion");
    // getValueRef("Motion");
    getValueRef("Hoang/", "FanControl");
    getValueRef("Truc/", "Soil");
    getValueRef("Truc/", "Trigger");
  }

  void getValueRef(String root, String refPath) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(fireBaseUri + root + refPath);
    databaseReference.onValue.listen((DatabaseEvent event) {
      Object? val = event.snapshot.value;
      notifyListeners();
      switch (refPath) {
        case "Soil": {
          soilData = val as int;
          break;
        }
        case "Trigger": {
          trigger = val as int;
          break;
        }
        case "Temperature": {
          temperatureData = val as int;
          print(temperatureData);
          break;
        }
        case "Humidity": {
          humidityData = val as int;
          break;
        }
        case "Buzzer": {
          buzzerData = val as int;
          break;
        }
        case "LightControl": {
          lightControl = val as int;
          break;
        }
        case "LightMotion": {
          lightMotion = val as int;
          break;
        }
        case "Motion": {
          motion = val as int;
          break;
        }
        case "FanControl": {
          fanControl = val as int;
          break;
        }
      }
    });
  }


  Future<void> setData(Map<String, Object?> value) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(fireBaseUri);
    // await ref.update({
    //   "123/age": 19,
    //   "123/address/line1": "1 Mountain View",
    // });
    await ref.update(value);
  }

  static GlobalProvider of (BuildContext context, {listen = true}) =>
      Provider.of<GlobalProvider>(context, listen: listen);
}