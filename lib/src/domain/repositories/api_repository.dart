import '../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/quote_entity.dart';

abstract class ApiRepository {
  Future<Either<Failure, QuoteEntity>> getRandomMovieQuote();
}