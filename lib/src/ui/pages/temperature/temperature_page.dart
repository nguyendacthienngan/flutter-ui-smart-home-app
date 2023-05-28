import 'package:flutter/material.dart';
import 'package:flutter_smart_home/src/ui/pages/temperature/components/MySwitch.dart';
import 'package:flutter_smart_home/src/ui/pages/temperature/components/my_select_button.dart';
import 'package:flutter_smart_home/src/ui/pages/temperature/components/my_slider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../presentation/provider/global_provider.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({Key? key}) : super(key: key);

  @override
  _TemperaturePageState createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  late GlobalProvider globalProvider;

  double fanControl = 15;
  double temperature = 26;
  double lightControl = 0;
  double soil = 2;
  double Triger = 0;

  bool isChangeData = true;

  void enableChangingData(title) {
    setState(() {
      // isChangeData = title == 'SERVICES';
    });
  }

  void updateData({key = "", value = 2}) {
    switch(key) {
      case "LightControl": {
        globalProvider.setData({
          "LightControl": value
        });
        break;
      }
      case "FanControl": {
        globalProvider.setData({
          "FanControl": value
        });
        break;
      }
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
  }

  Future<double> getTempData() async {
    return context.watch<GlobalProvider>().temperatureData.toDouble();
  }

  Future<double> getFanControl() async {
    return context.watch<GlobalProvider>().fanControl.toDouble();
  }

  Future<double> getLightControl() async {
    return context.watch<GlobalProvider>().lightControl.toDouble();
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
            getTempData(),
            getFanControl(),
            getLightControl()
          ]),
          builder: (context, AsyncSnapshot<List<double>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // If we got an error
              } else if (snapshot.hasData) {
                temperature = snapshot.data![0];
                fanControl = snapshot.data![1];
                lightControl = snapshot.data![2];
                debugPrint("data: ${snapshot.data}");

                // debugPrint('data: $temperature');

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
                          ),
                          RotatedBox(
                            quarterTurns: (temperature * 3.6).toInt(),
                            child: const Icon(
                              Icons.bar_chart_rounded,
                              color: Colors.indigo,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            const SizedBox(height: 32),
                            CircularPercentIndicator(
                              radius: 180,
                              lineWidth: 14,
                              percent: 0.75,
                              progressColor: Colors.indigo,
                              center: Text(
                                '$temperature\u00B0',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Center(
                              child: Text(
                                'TEMPERATURE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black54),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // MySelectButton(enableChangingData: enableChangingData),
                            const SizedBox(height: 32),
                            MySwitch(
                                title: "Light control",
                                value: lightControl,
                                updateData: updateData,
                                id: "LightControl"
                            ),
                            const SizedBox(height: 24),
                            MySwitch(
                                title: "Fan control",
                                value: fanControl,
                                updateData: updateData,
                                id: "FanControl"
                            ),
                            const SizedBox(height: 24),
                            // MySwitch(
                            //     title: "Watering tree",
                            //     value: Triger,
                            //     updateData: updateData,
                            //     id: "Triger"
                            // ),
                            const SizedBox(height: 24),
                            // MySlider(
                            //     id: "Soil",
                            //     title: 'Soil',
                            //     value: soil,
                            //     defaultValue: soil,
                            //     isEnableChangeData: isChangeData,
                            //     updateData: updateData,
                            //     scale: [Text('LOW'), Text('MID'), Text('HIGH')]
                            // ),
                            const SizedBox(height: 24),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     _fan(title: 'FAN 1', isActive: true),
                            //     _fan(title: 'FAN 2', isActive: false),
                            //     _fan(title: 'FAN 3'),
                            //   ],
                            // ),
                            // const SizedBox(height: 24),
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
