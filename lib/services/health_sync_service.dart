import 'package:health/health.dart';

class HealthSyncService {
  
  //função assíncrona para puxar os dados do HealthConnec
  Future pushDatatoModel(DateTime date) async {
    final Health health = Health();

    DateTime startTime = DateTime(date.year, date.month, date.day-1, 19, 0, 0);
    DateTime endTime = DateTime(date.year, date.month, date.day, 18, 59, 59);

    final types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BASAL_ENERGY_BURNED,
      HealthDataType.HEART_RATE,
      HealthDataType.SLEEP_LIGHT,
      HealthDataType.SLEEP_DEEP,
      HealthDataType.SLEEP_REM,
      HealthDataType.SLEEP_AWAKE,
    ];

    try {
      await health.requestAuthorization(types);
      
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        startTime: startTime, 
        endTime: endTime,
        types: types, 
      );

      healthData = health.removeDuplicates(healthData);

      //inicialização dos dados
      int steps = 0;
      double activeCal = 0.0;
      double basalCal = 0.0;
      List<double> heartRateSeries = [];
      double lightSleepSec = 0;
      double deepSleepSec = 0;
      double remSleepSec = 0;
      double awakeSleepSec = 0;

      for(var point in healthData) {
        if (point.value is NumericHealthValue) {
          final val = (point.value as NumericHealthValue).numericValue;

          if(point.type == HealthDataType.STEPS) {
            steps += val.toInt();
          } 
          else if(point.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
            activeCal += val.toDouble();
          } 
          else if(point.type == HealthDataType.BASAL_ENERGY_BURNED) {
            basalCal += val.toDouble();
          }      
          else if(point.type == HealthDataType.HEART_RATE) {
            heartRateSeries.add(val.toDouble());
          }
          else if(point.type == HealthDataType.SLEEP_LIGHT) {
            lightSleepSec += point.dateTo.difference(point.dateFrom).inSeconds;
          }
          else if(point.type == HealthDataType.SLEEP_DEEP) {
            deepSleepSec += point.dateTo.difference(point.dateFrom).inSeconds;
          }      
          else if(point.type == HealthDataType.SLEEP_REM) {
            remSleepSec += point.dateTo.difference(point.dateFrom).inSeconds;
          }      
          else if(point.type == HealthDataType.SLEEP_AWAKE) {
            awakeSleepSec += point.dateTo.difference(point.dateFrom).inSeconds;
          }      
        }
      }

        // --- Tratativas de algumas features ---
      double totalCalories = basalCal + activeCal;
      
      double minHr = 0;
      double maxHr = 0;
      double meanHr = 0.0;

      if (heartRateSeries.isNotEmpty) {
        minHr = heartRateSeries.reduce((a, b) => a < b ? a : b);
        maxHr = heartRateSeries.reduce((a, b) => a > b ? a : b);
        meanHr = heartRateSeries.reduce((a, b) => a + b) / heartRateSeries.length;
      }

      return {
        "steps": steps,
        "calories": totalCalories,
        "min_hr": minHr,
        "max_hr": maxHr,
        "mean_hr": meanHr,
        "lightSleep": lightSleepSec,
        "deepSleep": deepSleepSec,
        "remSleep": remSleepSec,
        "awakeSleep": awakeSleepSec,
      };

    } catch(e) {
      print("Erro: $e ");
    }
  }
} 