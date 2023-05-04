
import 'package:flutter/material.dart';
import 'package:flutter_smart_home/src/presentation/provider/global_provider.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late GlobalProvider globalProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      globalProvider = GlobalProvider.of(context, listen: false);
      // globalProvider.getMovieQuote();
      globalProvider.getSensorData();
    });
    super.initState();
  }

  Future getMovieQuote() async {
    globalProvider.getRandomMovieQuote;
  }

  @override
  Widget build(BuildContext context) {
    // final quote = context.watch<GlobalProvider>().randomQuote.quote;
    final tempData = context.watch<GlobalProvider>().temperatureData;
    final humData = context.watch<GlobalProvider>().humidityData;
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(tempData.toString()),
                Text(humData.toString())

              ]
          ),
        ),
      ),
    );
  }
}
