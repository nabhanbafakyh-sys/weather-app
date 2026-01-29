import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_cubit.dart';
import '../widgets/details.dart';
import '../widgets/hour_card.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => HomeCubit(WeatherService())..loadWeather("London"),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is Weather) {
                final weather = state.climate;
                final hourlyList = state.hourlyList;
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_pin, color: Colors.blueGrey),
                          Text(
                            weather.cityName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SearchScreen(),
                                ),
                              );

                              if (result != null && result is String) {
                                context.read<HomeCubit>().loadWeather(result);
                              }
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "${weather.temperature.round()}°C",
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              weather.condition,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
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
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hourlyList.length > 12
                              ? 12
                              : hourlyList.length,
                          itemBuilder: (context, index) {
                            return HourlyWeatherCard(
                              hour: hourlyList[index],
                              isSelected: false,
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.2,
                        children: [
                          DetailCard(
                            icon: Icons.water_drop_outlined,
                            title: "Humidity",
                            value: "${weather.humidity}%",
                          ),
                          DetailCard(
                            icon: Icons.air_outlined,
                            title: "Wind",
                            value: "${weather.windSpeed} m/s",
                          ),
                          DetailCard(
                            icon: Icons.thermostat_sharp,
                            title: "Feels Like",
                            value: "${weather.feelsLike.round()}°",
                          ),
                          DetailCard(
                            icon: Icons.compress,
                            title: "Pressure",
                            value: "${weather.pressure}",
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              if (state is HomeError) {
                return Center(child: Text(state.message));
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
