class CriteriaUnit{
  int lowerLimit;
  double gradePoints;
  bool isDistributed;

  CriteriaUnit({required this.lowerLimit, required this.gradePoints, required this.isDistributed});

  factory CriteriaUnit.fromJson(Map<String, dynamic> json) {
    return CriteriaUnit(
      lowerLimit: json['lowerLimit'],
      gradePoints: json['gradePoints'],
      isDistributed: json['isDistributed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lowerLimit': lowerLimit,
      'gradePoints': gradePoints,
      'isDistributed': isDistributed,
    };
  }
}