import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/error/exceptions.dart';
import '../../models/quote_model.dart';

abstract class ApiRemoteDataSource {
  Future<QuoteModel> getRandomMovieQuotes();
}

class ApiRemoteDataSourceImpl implements ApiRemoteDataSource {
  final http.Client httpClient;
  ApiRemoteDataSourceImpl(this.httpClient);
  @override
  Future<QuoteModel> getRandomMovieQuotes() async {
    final url = Uri.parse("https://mocki.io/v1/5ed57d19-826e-4e87-aeac-97c58b4ba30e");
    final response = await httpClient
        .get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}