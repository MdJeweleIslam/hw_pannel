
import 'dart:convert';

IndividualClassroomQuizAllListModel individualClassroomQuizAllListModelFromJson(String str) => IndividualClassroomQuizAllListModel.fromJson(json.decode(str));

String individualClassroomQuizAllListModelToJson(IndividualClassroomQuizAllListModel data) => json.encode(data.toJson());

class IndividualClassroomQuizAllListModel {
  IndividualClassroomQuizAllListModel({
    required this.error,
    required this.message,
    required this.data,
    required this.startTime,
    required this.endTime,
  });

  bool error;
  String message;
  List<IndividualClassroomQuizAllListItem> data;
  String startTime;
  String endTime;

  factory IndividualClassroomQuizAllListModel.fromJson(Map<String, dynamic> json) => IndividualClassroomQuizAllListModel(
    error: json["error"],
    message: json["message"],
    data: List<IndividualClassroomQuizAllListItem>.from(json["data"].map((x) => IndividualClassroomQuizAllListItem.fromJson(x))),
    startTime:  json["start_time"] ,
    endTime:  json["end_time"] ,
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "start_time": startTime ,
    "end_time": endTime ,
  };
}

class IndividualClassroomQuizAllListItem {
  IndividualClassroomQuizAllListItem({
    required this.quizTimeId,
    required this.isMainQuizTime,
    this.quizTimeIdFk,
    required this.quizDuration,
    required this.quizStartDate,
    required this.quizStartTime,
    required this.quizEndDate,
    required this.quizEndTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.classRoomId,
    required this.quizId,
    this.studentId,
    required this.quizInfo,
  });

  String quizTimeId;
  bool isMainQuizTime;
  dynamic quizTimeIdFk;
  String quizDuration;
  String quizStartDate;
  String quizStartTime;
  String quizEndDate;
  String quizEndTime;
  bool isActive;
  String createdAt;
  String updatedAt;
  String date;
  String classRoomId;
  String quizId;
  dynamic studentId;
  QuizInfo quizInfo;

  factory IndividualClassroomQuizAllListItem.fromJson(Map<String, dynamic> json) => IndividualClassroomQuizAllListItem(
    quizTimeId: json["quiz_time_id"].toString(),
    isMainQuizTime: json["is_main_quiz_time"],
    quizTimeIdFk: json["quiz_time_id_fk"],
    quizDuration: json["quiz_duration"].toString(),
    quizStartDate: json["quiz_start_date"],
    quizStartTime: json["quiz_start_time"],
    quizEndDate:  json["quiz_end_date"] ,
    quizEndTime: json["quiz_end_time"],
    isActive: json["is_active"],
    createdAt:  json["created_at"],
    updatedAt:  json["updated_at"] ,
    date: json["date"],
    classRoomId: json["class_room_id"].toString(),
    quizId: json["quiz_id"].toString(),
    studentId: json["student_id"],
    quizInfo: QuizInfo.fromJson(json["quiz_info"]),
  );

  Map<String, dynamic> toJson() => {
    "quiz_time_id": quizTimeId,
    "is_main_quiz_time": isMainQuizTime,
    "quiz_time_id_fk": quizTimeIdFk,
    "quiz_duration": quizDuration,
    "quiz_start_date": quizStartDate,
    "quiz_start_time": quizStartTime,
    "quiz_end_date":  quizEndDate ,
    "quiz_end_time": quizEndTime,
    "is_active": isActive,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "date": date ,
    "class_room_id": classRoomId,
    "quiz_id": quizId,
    "student_id": studentId,
    "quiz_info": quizInfo.toJson(),
  };
}

class QuizInfo {
  QuizInfo({
    required this.quizId,
    required this.quizTitle,
    required this.isDeleteQuiz,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.isComplete,
    required this.quizType,
    required this.teacherId,
    required this.classRoomId,
  });

  int quizId;
  String quizTitle;
  bool isDeleteQuiz;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime date;
  bool isComplete;
  int quizType;
  int teacherId;
  int classRoomId;

  factory QuizInfo.fromJson(Map<String, dynamic> json) => QuizInfo(
    quizId: json["quiz_id"],
    quizTitle: json["quiz_title"],
    isDeleteQuiz: json["is_delete_quiz"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    date: DateTime.parse(json["date"]),
    isComplete: json["is_complete"],
    quizType: json["quiz_type"],
    teacherId: json["teacher_id"],
    classRoomId: json["class_room_id"],
  );

  Map<String, dynamic> toJson() => {
    "quiz_id": quizId,
    "quiz_title": quizTitle,
    "is_delete_quiz": isDeleteQuiz,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "is_complete": isComplete,
    "quiz_type": quizType,
    "teacher_id": teacherId,
    "class_room_id": classRoomId,
  };
}
