// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'cubit/home_cubit.dart';
// import 'cubit/home_state.dart';
// import 'widgets/details.dart';
// import 'widgets/hour_card.dart';
// import '../search/search_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HomeCubit(),
//       child: Scaffold(
//         backgroundColor: Colors.lightBlue,
//         body: BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             if (state is HomeLoading) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (state is Weather) {
//               final weather = state.climate;
//               final hourlyList = state.hourlyList;

//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.location_pin, color: Colors.blueGrey),
//                         Text(
//                           weather.cityName,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Spacer(),
//                         IconButton(
//                           icon: Icon(Icons.search),
//                           onPressed: () async {
//                             final result = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => const SearchScreen(),
//                               ),
//                             );

//                             if (result is String) {
//                               context.read<HomeCubit>().loadWeather(result);
//                             }
//                           },
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 30),
//                     Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             "${weather.temperature.round()}°C",
//                             style: TextStyle(
//                               fontSize: 64,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             weather.condition,
//                             style: TextStyle(fontSize: 18, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: 30),
//                     Text(
//                       "Hourly Forecast",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     SizedBox(height: 12),
//                     SizedBox(
//                       height: 120,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: hourlyList.length > 12
//                             ? 12
//                             : hourlyList.length,
//                         itemBuilder: (context, index) {
//                           return HourlyWeatherCard(
//                             hour: hourlyList[index],
//                             isSelected: false,
//                             onTap: () {},
//                           );
//                         },
//                       ),
//                     ),

//                     SizedBox(height: 30),
//                     Text(
//                       "Details",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     GridView.count(
//                       crossAxisCount: 2,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       crossAxisSpacing: 18,
//                       mainAxisSpacing: 15,
//                       childAspectRatio: 1.2,
//                       children: [
//                         DetailCard(
//                           icon: Icons.water_drop_outlined,
//                           title: "Humidity",
//                           value: "${weather.humidity}%",
//                         ),
//                         DetailCard(
//                           icon: Icons.air_outlined,
//                           title: "Wind",
//                           value: "${weather.windSpeed} m/s",
//                         ),
//                         DetailCard(
//                           icon: Icons.thermostat,
//                           title: "Feels Like",
//                           value: "${weather.feelsLike.round()}°",
//                         ),
//                         DetailCard(
//                           icon: Icons.compress,
//                           title: "Pressure",
//                           value: "${weather.pressure}",
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }

//             if (state is HomeError) {
//               return Center(child: Text(state.message));
//             }

//             return SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'widgets/details.dart';
import 'widgets/hour_card.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  LinearGradient _getGradient(String condition) {
    final lower = condition.toLowerCase();

    if (lower.contains("rain")) {
      return const LinearGradient(
        colors: [Color(0xFF314755), Color(0xFF26A0DA)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    if (lower.contains("clear")) {
      final hour = DateTime.now().hour;

      if (hour >= 6 && hour < 18) {
        return const LinearGradient(
          colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      } else {
        return const LinearGradient(
          colors: [Color(0xFF141E30), Color(0xFF243B55)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      }
    }

    if (lower.contains("cloud")) {
      return const LinearGradient(
        colors: [Color(0xFF757F9A), Color(0xFFD7DDE8)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    return const LinearGradient(
      colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadWeather("Kochi"),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is Weather) {
              final weather = state.climate;
              final hourlyList = state.hourlyList;

              return Container(
                decoration: BoxDecoration(
                  gradient: _getGradient(weather.condition),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Location Row
                        Row(
                          children: [
                            const Icon(Icons.location_pin, color: Colors.white),
                            Text(
                              weather.cityName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SearchScreen(),
                                  ),
                                );

                                if (result is String) {
                                  context.read<HomeCubit>().loadWeather(result);
                                }
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Temperature Section
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "${weather.temperature.round()}°",
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                weather.condition,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        const Text(
                          "Hourly Forecast",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

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

                        const SizedBox(height: 30),

                        const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
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
                                icon: Icons.thermostat,
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
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (state is HomeError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
