import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/search_screen.dart';
import 'package:flutter_application_1/services/weather_services.dart';
import 'package:flutter_application_1/widgets/hour_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _service = WeatherService();

  bool isLoading = true;
  bool hourlyLoading = true;
  String city = "London";
  double temperature = 0;
  String condition = "";
  int humidity = 0;
  double windSpeed = 0;
  double feelsLike = 0;
  int pressure = 0;
  List hourlyList = [];
  int selectedHourIndex = 0;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  void updateCity(String newCity) {
    setState(() {
      city = newCity.trim();
      isLoading = true;
      hourlyLoading = true;
    });
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      final current = await _service.fetchCurrentWeather(city);
      final hourly = await _service.fetchHourlyForecast(city);

      setState(() {
        temperature = current['main']['temp'].toDouble();
        condition = current['weather'][0]['main'];
        humidity = current['main']['humidity'];
        windSpeed = current['wind']['speed'].toDouble();
        feelsLike = current['main']['feels_like'].toDouble();
        pressure = current['main']['pressure'];
        hourlyList = hourly['list'];
        isLoading = false;
        hourlyLoading = false;
      });
    } catch (e) {
      debugPrint("ERROR: $e");
      setState(() {
        isLoading = false;
        hourlyLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("City not found. Try another city.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 236, 236),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_pin, color: Colors.blueGrey),
                        Text(
                          city,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SearchScreen(),
                              ),
                            );

                            if (result != null && result is String) {
                              updateCity(result);
                            }
                          },
                          child: const Icon(Icons.search),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "${temperature.round()}°c",
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      condition,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: hourlyLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: hourlyList.length > 12
                                  ? 12
                                  : hourlyList.length,
                              itemBuilder: (context, index) {
                                final hour = hourlyList[index];
                                return HourlyWeatherCard(
                                  hour: hour,
                                  isSelected: index == selectedHourIndex,
                                  onTap: () {
                                    setState(() {
                                      selectedHourIndex = index;
                                    });
                                  },
                                );
                              },
                            ),
                    ),

                    SizedBox(height: 30),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 18,
                      childAspectRatio: 1.2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        detailCard(
                          Icons.water_drop_outlined,
                          "Humidity",
                          "$humidity%",
                        ),
                        detailCard(
                          Icons.air_outlined,
                          "Wind",
                          "$windSpeed m/s",
                        ),
                        detailCard(
                          Icons.thermostat_sharp,
                          "Feels Like",
                          "${feelsLike.round()}°",
                        ),
                        detailCard(Icons.compress, "Pressure", "$pressure"),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget detailCard(IconData icon, String title, String value) {
    return Container(
      height: 10,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 30, color: Colors.blueGrey),
              Text(
                title,
                style: TextStyle(color: Colors.blueGrey, fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
