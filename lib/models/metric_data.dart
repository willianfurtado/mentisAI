class MetricData {
  final int? id; 
  final String date; 
  final int steps;
  final int calories;
  final double sleepQuality; 

  MetricData({
    this.id,
    required this.date,
    required this.steps,
    required this.calories,
    required this.sleepQuality,
  });

  factory MetricData.fromMap(Map<String, dynamic> map) {
    return MetricData(
      id: map['id'],
      date: map['date'],
      steps: map['steps'],
      calories: map['calories'],
      sleepQuality: map['sleepQuality'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'steps': steps,
      'calories': calories,
      'sleepQuality': sleepQuality,
    };
  }
}