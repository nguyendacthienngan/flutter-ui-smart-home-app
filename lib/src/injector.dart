import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_home/src/data/datasources/remote/api_remote_datasource.dart';
import 'package:flutter_smart_home/src/data/repositories/api_repository_impl.dart';
import 'package:flutter_smart_home/src/domain/usecases/get_random_movie_quote.dart';
import 'package:flutter_smart_home/src/presentation/provider/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Injector extends StatelessWidget {
  final Widget? router;

  const Injector({Key? key, this.router}): super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => GlobalProvider(
              getRandomMovieQuote: GetRandomMovieQuote(
                ApiRepositoryImpl(
                  ApiRemoteDataSourceImpl(http.Client())
                ),
              ))
      )
    ],
    child: router
  );
}