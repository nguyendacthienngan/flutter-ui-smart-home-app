import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_home/src/domain/entities/quote_entity.dart';
import 'package:flutter_smart_home/src/domain/usecases/get_random_movie_quote.dart';
import 'package:provider/provider.dart';

class GlobalProvider extends ChangeNotifier {
  final GetRandomMovieQuote getRandomMovieQuote;
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

  static GlobalProvider of (BuildContext context, {listen = true}) =>
      Provider.of<GlobalProvider>(context, listen: listen);
}