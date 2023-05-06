import 'package:flutter/material.dart';
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

  double fanSpeed = 15;
  double temperature = 26;
  double lightControl = 0;
  bool isChangeData = false;

  void enableChangingData(title) {
    setState(() {
      isChangeData = title == 'SERVICES';
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
      case "FanSpeed": {
        globalProvider.setData({
          "FanSpeed": value
        });
        break;
      }
    }
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      globalProvider = GlobalProvider.of(context, listen: false);
      // globalProvider.getMovieQuote();
      globalProvider.getSensorData();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      temperature = context.watch<GlobalProvider>().temperatureData.toDouble();
      fanSpeed = context.watch<GlobalProvider>().fanSpeed.toDouble();
      lightControl = context.watch<GlobalProvider>().lightControl.toDouble();
    });
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
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
                    MySelectButton(enableChangingData: enableChangingData),
                    const SizedBox(height: 32),
                    MySlider(
                        id: "LightControl",
                        value: lightControl,
                        defaultValue: lightControl,
                        isEnableChangeData: isChangeData,
                        title: 'LIGHT',
                        updateData: updateData,
                        scale: const [Text('0%'), Text('50%'), Text('100%')],
                    ),
                    const SizedBox(height: 24),
                    MySlider(
                        id: "FanSpeed",
                        title: 'Fan Speed',
                        value: fanSpeed,
                        defaultValue: fanSpeed,
                        isEnableChangeData: isChangeData,
                        updateData: updateData,
                        scale: [Text('LOW'), Text('MID'), Text('HIGH')]
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _fan(title: 'FAN 1', isActive: true),
                        _fan(title: 'FAN 2', isActive: false),
                        _fan(title: 'FAN 3'),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
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
