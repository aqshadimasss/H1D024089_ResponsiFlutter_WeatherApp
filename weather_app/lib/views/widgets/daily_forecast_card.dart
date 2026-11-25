import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/weather_code.dart';

class DailyForecastCard extends StatelessWidget {
  final String date;
  final int weatherCode;
  final double maxTemp;
  final double minTemp;
  final int precipitationProbability;

  const DailyForecastCard({
    super.key,
    required this.date,
    required this.weatherCode,
    required this.maxTemp,
    required this.minTemp,
    required this.precipitationProbability,
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(date);
    final dayName = DateFormat('EEE').format(dateTime);
    final dayDate = DateFormat('MMM d').format(dateTime);
    final isToday = DateFormat('yyyy-MM-dd').format(DateTime.now()) == date;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isToday
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isToday ? 'Today' : dayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isToday
                            ? Theme.of(context).colorScheme.primary
                            : const Color(0xFF1A1A1A),
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  dayDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),

          // Weather Icon
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: WeatherCodeUtil.getColor(weatherCode)
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                WeatherCodeUtil.getIcon(weatherCode),
                size: 28,
                color: WeatherCodeUtil.getColor(weatherCode),
              ),
            ),
          ),

          // Precipitation
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.water_drop,
                    size: 14,
                    color: Color(0xFF2196F3),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$precipitationProbability%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF2196F3),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Temperature Range
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${maxTemp.round()}°',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${minTemp.round()}°',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
