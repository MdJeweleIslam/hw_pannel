
import 'dart:convert';

IndividualClassroomQuizAllListModel individualClassroomQuizAllListModelFromJson(String str) => IndividualClassroomQuizAllListModel.fromJson(json.decode(str));

String individualClassroomQuizAllListModelToJson(IndividualClassroomQuizAllListModel data) => json.encode(data.toJson());

class IndividualClassroomQuizAllListModel {
  IndividualClassroomQuizAllListModel({
    required this.error,
    required this.message,
    required this.data,
    required this.currentTimes,
  });

  bool error;
  String message;
  List<Datum> data;
  DateTime currentTimes;

  factory IndividualClassroomQuizAllListModel.fromJson(Map<String, dynamic> json) => IndividualClassroomQuizAllListModel(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    currentTimes: DateTime.parse(json["current_times"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "current_times": currentTimes.toIso8601String(),
  };
}
class Datum {
  Datum({
    required this.studentJoinClassroomId,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.classRoomId,
    required this.studentId,
    required this.userInfo,
    required this.classroomInfo,
  });

  int studentJoinClassroomId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime date;
  int classRoomId;
  int studentId;
  UserInfo userInfo;
  ClassroomInfo classroomInfo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    studentJoinClassroomId: json["student_join_classroom_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    date: DateTime.parse(json["date"]),
    classRoomId: json["class_room_id"],
    studentId: json["student_id"],
    userInfo: UserInfo.fromJson(json["user_info"]),
    classroomInfo: ClassroomInfo.fromJson(json["classroom_info"]),
  );

  Map<String, dynamic> toJson() => {
    "student_join_classroom_id": studentJoinClassroomId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "class_room_id": classRoomId,
    "student_id": studentId,
    "user_info": userInfo.toJson(),
    "classroom_info": classroomInfo.toJson(),
  };
}

class ClassroomInfo {
  ClassroomInfo({
    required this.classRoomId,
    required this.classRoomName,
    required this.classRoomCode,
    required this.batch,
    required this.isDeleteClassroom,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    this.userId,
    required this.quizInfo,
  });

  int classRoomId;
  String classRoomName;
  String classRoomCode;
  String batch;
  bool isDeleteClassroom;
  String createdAt;
  String updatedAt;
  String date;
  dynamic userId;
  List<QuizInfo> quizInfo;

  factory ClassroomInfo.fromJson(Map<String, dynamic> json) => ClassroomInfo(
    classRoomId: json["class_room_id"],
    classRoomName: json["class_room_name"],
    classRoomCode: json["class_room_code"],
    batch: json["batch"],
    isDeleteClassroom: json["is_delete_classroom"],
    createdAt:  json["created_at"] ,
    updatedAt:  json["updated_at"] ,
    date:  json["date"] ,
    userId: json["user_id"],
    quizInfo: List<QuizInfo>.from(json["quiz_info"].map((x) => QuizInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "class_room_id": classRoomId,
    "class_room_name": classRoomName,
    "class_room_code": classRoomCode,
    "batch": batch,
    "is_delete_classroom": isDeleteClassroom,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "date": date,
    "user_id": userId,
    "quiz_info": List<dynamic>.from(quizInfo.map((x) => x.toJson())),
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
    required this.quizTimeInfo,
  });

  int quizId;
  String quizTitle;
  bool isDeleteQuiz;
  String createdAt;
  String updatedAt;
  String date;
  bool isComplete;
  int quizType;
  int teacherId;
  int classRoomId;
  List<QuizTimeInfo> quizTimeInfo;

  factory QuizInfo.fromJson(Map<String, dynamic> json) => QuizInfo(
    quizId: json["quiz_id"],
    quizTitle: json["quiz_title"],
    isDeleteQuiz: json["is_delete_quiz"],
    createdAt:  json["created_at"] ,
    updatedAt: json["updated_at"] ,
    date:  json["date"] ,
    isComplete: json["is_complete"],
    quizType: json["quiz_type"],
    teacherId: json["teacher_id"],
    classRoomId: json["class_room_id"],
    quizTimeInfo: List<QuizTimeInfo>.from(json["quiz_time_info"].map((x) => QuizTimeInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quiz_id": quizId,
    "quiz_title": quizTitle,
    "is_delete_quiz": isDeleteQuiz,
    "created_at": createdAt ,
    "updated_at": updatedAt ,
    "date": date,
    "is_complete": isComplete,
    "quiz_type": quizType,
    "teacher_id": teacherId,
    "class_room_id": classRoomId,
    "quiz_time_info": List<dynamic>.from(quizTimeInfo.map((x) => x.toJson())),
  };
}

class QuizTimeInfo {
  QuizTimeInfo({
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
  });

  int quizTimeId;
  bool isMainQuizTime;
  dynamic quizTimeIdFk;
  int quizDuration;
  String quizStartDate;
  String quizStartTime;
  String quizEndDate;
  String quizEndTime;
  bool isActive;
  String createdAt;
  String updatedAt;
  String date;
  int classRoomId;
  int quizId;
  dynamic studentId;

  factory QuizTimeInfo.fromJson(Map<String, dynamic> json) => QuizTimeInfo(
    quizTimeId: json["quiz_time_id"],
    isMainQuizTime: json["is_main_quiz_time"],
    quizTimeIdFk: json["quiz_time_id_fk"],
    quizDuration: json["quiz_duration"],
    quizStartDate:  json["quiz_start_date"] ,
    quizStartTime: json["quiz_start_time"],
    quizEndDate:  json["quiz_end_date"] ,
    quizEndTime: json["quiz_end_time"],
    isActive: json["is_active"],
    createdAt:  json["created_at"] ,
    updatedAt: json["updated_at"],
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
    "date":date,
    "class_room_id": classRoomId,
    "quiz_id": quizId,
    "student_id": studentId,
  };
}

class UserInfo {
  UserInfo({
    required this.id,
    this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.email,
    required this.uid,
    required this.phoneNumber,
    required this.apiKey,
    required this.gender,
    required this.isStudent,
    required this.isTeacher,
    required this.date,
    required this.groups,
    required this.userPermissions,
  });

  int id;
  dynamic lastLogin;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  bool isStaff;
  bool isActive;
  String dateJoined;
  String email;
  String uid;
  String phoneNumber;
  String apiKey;
  String gender;
  bool isStudent;
  bool isTeacher;
  String date;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    lastLogin: json["last_login"],
    isSuperuser: json["is_superuser"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: json["date_joined"] ,
    email: json["email"],
    uid: json["uid"],
    phoneNumber: json["phone_number"],
    apiKey: json["api_key"],
    gender: json["gender"],
    isStudent: json["is_student"],
    isTeacher: json["is_teacher"],
    date: json["date"] ,
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin,
    "is_superuser": isSuperuser,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "is_staff": isStaff,
    "is_active": isActive,
    "date_joined": dateJoined ,
    "email": email,
    "uid": uid,
    "phone_number": phoneNumber,
    "api_key": apiKey,
    "gender": gender,
    "is_student": isStudent,
    "is_teacher": isTeacher,
    "date":date,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
  };
}
