
import 'package:dartz/dartz.dart';
import 'package:flutter_smart_home/src/domain/entities/quote_entity.dart';
import 'package:flutter_smart_home/src/domain/repositories/api_repository.dart';

import '../../core/error/failures.dart';

class GetRandomMovieQuote {
  final ApiRepository repository;

  GetRandomMovieQuote(this.repository);

  Future<Either<Failure, QuoteEntity>> execute() async =>
      await repository.getRandomMovieQuote();
}