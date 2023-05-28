import 'package:flutter/material.dart';
import 'package:flutter_smart_home/src/ui/pages/temperature/components/MySwitch.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../presentation/provider/global_provider.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> with TickerProviderStateMixin {
  late GlobalProvider globalProvider;

  double soil = 2;
  double Triger = 0;

  bool isChangeData = true;

  late final AnimationController _controller;

  void enableChangingData(title) {
    setState(() {
      // isChangeData = title == 'SERVICES';
    });
  }

  void updateData({key = "", value = 2}) {
    switch(key) {
      case "Soil": {
        globalProvider.setData({
          "Soil": value
        });
        break;
      }
      case "Triger": {
        globalProvider.setData({
          "Triger": value
        });
        print("Triger: $value");
        if (value == 1) {
          if (!_controller.isCompleted) {
            _controller.forward();
          } else {
            _controller.repeat();
          }
        } else {
          _controller.stop();
        }
        break;
      }
    }
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      globalProvider = GlobalProvider.of(context, listen: false);
      globalProvider.getSensorData();

    });
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<double> getTrigerData() async {
    return context.watch<GlobalProvider>().Triger.toDouble();
  }

  Future<double> getSoilData() async {
    return context.watch<GlobalProvider>().soilData.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: FutureBuilder(

          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future: Future.wait([
            getTrigerData(),
            getSoilData()
          ]),
          builder: (context, AsyncSnapshot<List<double>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // If we got an error
              } else if (snapshot.hasData) {
                debugPrint('Triger: $Triger');
                Triger = snapshot.data![0];

                // Extracting data from snapshot object
                return Container(
                  margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.indigo,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/animation/watering-plants.json',
                            controller: _controller,
                            onLoaded: (composition) {
                              // Configure the AnimationController with the duration of the
                              // Lottie file and start the animation.
                              // print("Triger: $value");

                              if (Triger != 0) {
                                _controller
                                  ..duration = composition.duration
                                  ..forward();
                              }
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            const SizedBox(height: 32),
                            MySwitch(
                                title: "Water control",
                                value: Triger,
                                updateData: updateData,
                                id: "Triger"
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            // Displaying LoadingSpinner to indicate waiting state
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _fan({
    required String title,
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isActive ? Colors.indigo : Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Image.asset(
            isActive ? 'assets/images/fan-2.png' : 'assets/images/fan-1.png',
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.black87 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
