
import 'package:dartz/dartz.dart';
import 'package:flutter_smart_home/src/core/error/failures.dart';
import 'package:flutter_smart_home/src/data/datasources/remote/api_remote_datasource.dart';
import 'package:flutter_smart_home/src/domain/entities/quote_entity.dart';
import 'package:flutter_smart_home/src/domain/repositories/api_repository.dart';

import '../../core/error/exceptions.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiRemoteDataSource apiRemoteDataSource;
  ApiRepositoryImpl(this.apiRemoteDataSource);
  @override
  Future<Either<Failure, QuoteEntity>> getRandomMovieQuote() async {
    try {
      final randomQuote = await apiRemoteDataSource.getRandomMovieQuotes();
      return Right(randomQuote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}