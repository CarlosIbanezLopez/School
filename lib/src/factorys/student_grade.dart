class StudentGrade {
  final int id;
  final int year;
  final int studentName;
  final int subjectName;
  final int cycleId;
  final int createUid;
  final int writeUid;
  final DateTime createDate;
  final DateTime writeDate;
  final double grade;

  StudentGrade({
    required this.id,
    required this.year,
    required this.studentName,
    required this.subjectName,
    required this.cycleId,
    required this.createUid,
    required this.writeUid,
    required this.createDate,
    required this.writeDate,
    required this.grade,
  });

  factory StudentGrade.fromJson(Map<String, dynamic> json) {
    return StudentGrade(
      id: json['id'],
      year: json['year'],
      studentName: json['student_name'],
      subjectName: json['subject_name'],
      cycleId: json['cycle_id'],
      createUid: json['create_uid'],
      writeUid: json['write_uid'],
      createDate: DateTime.parse(json['create_date']),
      writeDate: DateTime.parse(json['write_date']),
      grade: json['grade'],
    );
  }
}
