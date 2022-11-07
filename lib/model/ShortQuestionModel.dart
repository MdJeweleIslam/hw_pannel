// To parse this JSON data, do
//
//     final shortQuestionModel = shortQuestionModelFromJson(jsonString);

import 'dart:convert';

ShortQuestionModel shortQuestionModelFromJson(String str) => ShortQuestionModel.fromJson(json.decode(str));

String shortQuestionModelToJson(ShortQuestionModel data) => json.encode(data.toJson());

class ShortQuestionModel {
  ShortQuestionModel({
    this.error,
    this.message,
    required this.data,
    required this.totalQuestions,
    required this.questionsAnswerSubmitted,
    required this.currentTimess,
  });

  bool? error;
  String? message;
  List<Datum> data;
  int totalQuestions;
  int questionsAnswerSubmitted;
  String currentTimess;

  factory ShortQuestionModel.fromJson(Map<String, dynamic> json) => ShortQuestionModel(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalQuestions: json["total_questions"],
    questionsAnswerSubmitted: json["questions_answer_submitted"],
    currentTimess:json["current_timess"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total_questions": totalQuestions,
    "questions_answer_submitted": questionsAnswerSubmitted,
    "current_timess": currentTimess,
  };
}

class Datum {
  Datum({
    required this.questionId,
    required this.questionName,
    required this.isMcqQuestions,
    required this.isShortQuestions,
    required this.correctAnswer,
    required this.correctAnswer1,
    required this.correctAnswer2,
    required this.correctAnswer3,
    required this.questionMark,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.teacherId,
    this.quizId,
    this.quizType,
    this.teacherInfo,
    this.quizInfo,
    required this.questionsOptions,
  });

  int questionId;
  String questionName;
  bool isMcqQuestions;
  bool isShortQuestions;
  String correctAnswer;
  String correctAnswer1;
  String correctAnswer2;
  String correctAnswer3;
  String questionMark;
  String? createdAt;
  String? updatedAt;
  String? date;
  int? teacherId;
  int? quizId;
  int? quizType;
  TeacherInfo? teacherInfo;
  QuizInfo? quizInfo;
  List<dynamic> questionsOptions;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    questionId: json["question_id"],
    questionName: json["question_name"],
    isMcqQuestions: json["is_mcq_questions"],
    isShortQuestions: json["is_short_questions"],
    correctAnswer: json["correct_answer"],
    correctAnswer1: json["correct_answer1"],
    correctAnswer2: json["correct_answer2"],
    correctAnswer3: json["correct_answer3"],
    questionMark: json["question_mark"],
    createdAt:json["created_at"],
    updatedAt:json["updated_at"],
    date: json["date"],
    teacherId: json["teacher_id"],
    quizId: json["quiz_id"],
    quizType: json["quiz_type"],
    teacherInfo: TeacherInfo.fromJson(json["teacher_info"]),
    quizInfo: QuizInfo.fromJson(json["quiz_info"]),
    questionsOptions: List<dynamic>.from(json["questions_options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "question_name": questionName,
    "is_mcq_questions": isMcqQuestions,
    "is_short_questions": isShortQuestions,
    "correct_answer": correctAnswer,
    "correct_answer1": correctAnswer1,
    "correct_answer2": correctAnswer2,
    "correct_answer3": correctAnswer3,
    "question_mark": questionMark,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "date": date,
    "teacher_id": teacherId,
    "quiz_id": quizId,
    "quiz_type": quizType,
    "teacher_info": teacherInfo ,
    "quiz_info": quizInfo ,
    "questions_options": List<dynamic>.from(questionsOptions.map((x) => x)),
  };
}

class QuizInfo {
  QuizInfo({
    this.quizId,
    this.quizTitle,
    this.isDeleteQuiz,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.isComplete,
    this.quizType,
    this.teacherId,
    this.classRoomId,
    this.teacherInfo,
    this.classRoomInfo,
    required this.quizTimeInfo,
  });

  int? quizId;
  String? quizTitle;
  bool ?isDeleteQuiz;
  String? createdAt;
  String ?updatedAt;
  String? date;
  bool? isComplete;
  int? quizType;
  int ?teacherId;
  int? classRoomId;
  TeacherInfo? teacherInfo;
  ClassRoomInfo? classRoomInfo;
  List<QuizTimeInfo> quizTimeInfo;

  factory QuizInfo.fromJson(Map<String, dynamic> json) => QuizInfo(
    quizId: json["quiz_id"],
    quizTitle: json["quiz_title"],
    isDeleteQuiz: json["is_delete_quiz"],
    createdAt:json["created_at"],
    updatedAt: json["updated_at"],
    date: json["date"],
    isComplete: json["is_complete"],
    quizType: json["quiz_type"],
    teacherId: json["teacher_id"],
    classRoomId: json["class_room_id"],
    teacherInfo: TeacherInfo.fromJson(json["teacher_info"]),
    classRoomInfo: ClassRoomInfo.fromJson(json["class_room_info"]),
    quizTimeInfo: List<QuizTimeInfo>.from(json["quiz_time_info"].map((x) => QuizTimeInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quiz_id": quizId,
    "quiz_title": quizTitle,
    "is_delete_quiz": isDeleteQuiz,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "date": date,
    "is_complete": isComplete,
    "quiz_type": quizType,
    "teacher_id": teacherId,
    "class_room_id": classRoomId,
    "teacher_info": teacherInfo,
    "class_room_info": classRoomInfo,
    "quiz_time_info": List<dynamic>.from(quizTimeInfo.map((x) => x.toJson())),
  };
}

class ClassRoomInfo {
  ClassRoomInfo({
    this.classRoomId,
    this.classRoomName,
    this.classRoomCode,
    this.batch,
    this.isDeleteClassroom,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.userId,
  });

  int? classRoomId;
  String ?classRoomName;
  String? classRoomCode;
  String? batch;
  bool? isDeleteClassroom;
  String? createdAt;
  String? updatedAt;
  String? date;
  dynamic userId;

  factory ClassRoomInfo.fromJson(Map<String, dynamic> json) => ClassRoomInfo(
    classRoomId: json["class_room_id"],
    classRoomName: json["class_room_name"],
    classRoomCode: json["class_room_code"],
    batch: json["batch"],
    isDeleteClassroom: json["is_delete_classroom"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    date: json["date"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "class_room_id": classRoomId,
    "class_room_name": classRoomName,
    "class_room_code": classRoomCode,
    "batch": batch,
    "is_delete_classroom": isDeleteClassroom,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "date":date,
    "user_id": userId,
  };
}

class QuizTimeInfo {
  QuizTimeInfo({
    this.quizTimeId,
    this.isMainQuizTime,
    this.quizTimeIdFk,
    this.quizDuration,
    this.quizStartDate,
    this.quizStartTime,
    this.quizEndDate,
    this.quizEndTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.classRoomId,
    this.quizId,
    this.studentId,
  });

  int ?quizTimeId;
  bool? isMainQuizTime;
  dynamic? quizTimeIdFk;
  int ?quizDuration;
  String? quizStartDate;
  String? quizStartTime;
  String? quizEndDate;
  String? quizEndTime;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? date;
  int? classRoomId;
  int? quizId;
  dynamic studentId;

  factory QuizTimeInfo.fromJson(Map<String, dynamic> json) => QuizTimeInfo(
    quizTimeId: json["quiz_time_id"],
    isMainQuizTime: json["is_main_quiz_time"],
    quizTimeIdFk: json["quiz_time_id_fk"],
    quizDuration: json["quiz_duration"],
    quizStartDate: json["quiz_start_date"],
    quizStartTime: json["quiz_start_time"],
    quizEndDate: json["quiz_end_date"],
    quizEndTime: json["quiz_end_time"],
    isActive: json["is_active"],
    createdAt:  json["created_at"] ,
    updatedAt:  json["updated_at"] ,
    date:  json["date"] ,
    classRoomId: json["class_room_id"],
    quizId: json["quiz_id"],
    studentId: json["student_id"],
  );

  Map<String, dynamic> toJson() => {
    "quiz_time_id": quizTimeId,
    "is_main_quiz_time": isMainQuizTime,
    "quiz_time_id_fk": quizTimeIdFk,
    "quiz_duration": quizDuration,
    "quiz_start_date": quizStartDate,
    "quiz_start_time": quizStartTime,
    "quiz_end_date": quizEndDate,
    "quiz_end_time": quizEndTime,
    "is_active": isActive,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "date": date,
    "class_room_id": classRoomId,
    "quiz_id": quizId,
    "student_id": studentId,
  };
}

class TeacherInfo {
  TeacherInfo({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.email,
    this.uid,
    this.phoneNumber,
    this.apiKey,
    this.gender,
    this.isStudent,
    this.isTeacher,
    this.date,
    required this.groups,
    required this.userPermissions,
  });

  int? id;
  dynamic? lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  bool? isStaff;
  bool? isActive;
  String? dateJoined;
  String? email;
  String? uid;
  String? phoneNumber;
  String? apiKey;
  String? gender;
  bool? isStudent;
  bool? isTeacher;
  String? date;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  factory TeacherInfo.fromJson(Map<String, dynamic> json) => TeacherInfo(
    id: json["id"],
    lastLogin: json["last_login"],
    isSuperuser: json["is_superuser"] == null ? null : json["is_superuser"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isStaff: json["is_staff"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    dateJoined: json["date_joined"] ,
    email: json["email"],
    uid: json["uid"],
    phoneNumber: json["phone_number"],
    apiKey: json["api_key"],
    gender: json["gender"],
    isStudent: json["is_student"],
    isTeacher: json["is_teacher"],
    date:  json["date"] ,
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin,
    "is_superuser": isSuperuser == null ? null : isSuperuser,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "is_staff": isStaff,
    "is_active": isActive == null ? null : isActive,
    "date_joined": dateJoined ,
    "email": email,
    "uid": uid,
    "phone_number": phoneNumber,
    "api_key": apiKey,
    "gender": gender,
    "is_student": isStudent,
    "is_teacher": isTeacher,
    "date": date,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
  };
}
