//Interfaces class
class ClassInfoData {
  String room_time_table_id;
  String room_id;
  String on_week_date;
  String sec;
  String date;
  String started_time;
  String ended_time;
  String subject_teacher_id;
  String is_started;
  String room_number;
  String subject_id;
  String teacher_id;
  String subject_name;
  String email;
  String first_name;
  String last_name;

  ClassInfoData({
    this.room_time_table_id='0',
    this.room_id='0',
    this.on_week_date="กำลังตรวจสอบ",
    this.sec="กำลังตรวจสอบ",
    this.date="กำลังตรวจสอบ",
    this.started_time="กำลังตรวจสอบ",
    this.ended_time="กำลังตรวจสอบ",
    this.subject_teacher_id='0',
    this.is_started='0',
    this.room_number="กำลังตรวจสอบ",
    this.subject_id='0',
    this.teacher_id='0',
    this.subject_name="กำลังตรวจสอบ",
    this.email="กำลังตรวจสอบ",
    this.first_name="กำลังตรวจสอบ",
    this.last_name="กำลังตรวจสอบ"
  });

  factory ClassInfoData.fromJson(Map<String, dynamic> json) => ClassInfoData(
    room_time_table_id:json['room_time_table_id'],
    room_id:json['room_id'],
    on_week_date:json['on_week_date'],
    sec:json['sec'],
    date:json['date'],
    started_time:json['started_time'],
    ended_time:json['ended_time'],
    subject_teacher_id:json['subject_teacher_id'],
    is_started:json['is_started'],
    room_number:json['room_number'],
    subject_id:json['subject_id'],
    teacher_id:json['teacher_id'],
    subject_name:json['subject_name'],
    email:json['email'],
    first_name:json['first_name'],
    last_name:json['last_name']
  );

  Map<String, dynamic> toJson() =>{
    "room_time_table_id":room_time_table_id,
    "room_id":room_id,
    "on_week_date":on_week_date,
    "sec":sec,
    "date":date,
    "started_time":started_time,
    "ended_time":ended_time,
    "subject_teacher_id":subject_teacher_id,
    "is_started":is_started,
    "room_number":room_number,
    "subject_id":subject_id,
    "teacher_id":teacher_id,
    "subject_name":subject_name,
    "email":email,
    "first_name":first_name,
    "last_name":last_name
  };

}

class UserInfo {
  String student_id;
  String first_name;
  String last_name;
  String entry_year;
  String group;

  UserInfo({
    this.student_id="กำลังตรวจสอบ",
    this.first_name="กำลังตรวจสอบ",
    this.last_name="กำลังตรวจสอบ",
    this.entry_year="กำลังตรวจสอบ",
    this.group="กำลังตรวจสอบ"
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    student_id:json['student_id'],
    first_name:json['first_name'],
    last_name:json['last_name'],
    entry_year:json['entry_year'],
    group:json['group']
  );

  Map<String, dynamic> toJson()=>{
    "student_id":student_id,
    "first_name":first_name,
    "last_name":last_name,
    "entry_year":entry_year,
    "group":group
  };

}

class Term {
  String term_id;
  String term_name;

  Term({
    this.term_id="0",
    this.term_name="กำลังตรวจสอบ",
  });

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    term_id:json['term_id'],
    term_name:json['term_name'],
  );

  Map<String, dynamic> toJson()=>{
    "term_id":term_id,
    "term_name":term_name
  };

}

class DeviceInfo{
  String device_id;
  String device_name;
  String device_mac_address;
  String room_id;

  DeviceInfo({
    this.device_id,
    this.device_name,
    this.device_mac_address,
    this.room_id
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
    device_id:json['device_id'],
    device_name:json['device_name'],
    device_mac_address:json['device_mac_address'],
    room_id:json['room_id']
  );

  Map<String, dynamic> toJson()=>{
    "device_id":device_id,
    "device_name":device_name,
    "device_mac_address":device_mac_address,
    "room_id":room_id
  };

}