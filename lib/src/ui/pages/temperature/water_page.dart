import 'package:flutter/material.dart';
import 'package:flutter_smart_home/src/ui/pages/temperature/components/MySwitch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../presentation/provider/global_provider.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  late GlobalProvider globalProvider;

  double soil = 2;
  double trigger = 0;

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
      case "Trigger": {
        globalProvider.setData({
          "Trigger": value
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
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            const SizedBox(height: 32),
                            MySwitch(
                                title: "Water control",
                                value: trigger,
                                updateData: updateData,
                                id: "Trigger"
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
