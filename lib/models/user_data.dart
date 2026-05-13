class UserData {
  final int? id;
  final String gender;
  final String dateOfBirth;
  final String maritalStatus;
  final String educationLevel;
  final String profession;
  final String income;
  final String familyArrangement;
  final String children;
  final String residence;
  final String smartwatch;

  UserData({
    this.id,
    required this.gender,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.educationLevel,
    required this.profession,
    required this.income,
    required this.familyArrangement,
    required this.children,
    required this.residence,
    required this.smartwatch,
  });

  //transforma o Map do banco em um objeto UserData
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      gender: map['gender'], 
      dateOfBirth: map['dateOfBirth'], 
      maritalStatus: map['maritalStatus'], 
      educationLevel: map['educationLevel'], 
      profession: map['profession'], 
      income: map['income'], 
      familyArrangement: map['familyArrangement'],
      children: map['children'], 
      residence: map['residence'], 
      smartwatch: map['smartwatch']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'maritalStatus': maritalStatus,
      'educationLevel': educationLevel,
      'profession': profession,
      'income': income,
      'familyArrangement': familyArrangement,
      'children': children, 
      'residence': residence,
      'smartwatch': smartwatch,
    };
  }
}