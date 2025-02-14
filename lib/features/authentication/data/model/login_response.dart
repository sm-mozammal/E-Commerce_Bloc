// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? status;
  String? message;
  String? token;
  int? id;
  Data? data;

  LoginResponse({
    this.status,
    this.message,
    this.token,
    this.id,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        id: json["id"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "id": id,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  dynamic roasterGroupId;
  String? userType;
  dynamic depotId;
  String? cardNo;
  String? email;
  String? password;
  String? mobile;
  String? type;
  DateTime? joiningDate;
  DateTime? inactiveDate;
  String? bankAccount;
  String? bloodGroup;
  DateTime? dateOfBirth;
  String? presentAddress;
  dynamic permanentAddress;
  String? emergencyContact;
  dynamic reference;
  int? gradeId;
  int? designationId;
  int? departmentId;
  dynamic requisitionId;
  dynamic candidateId;
  int? companyLocationId;
  dynamic workplaceId;
  dynamic workplaceType;
  dynamic notes;
  int? departmentHead;
  int? approvedBy;
  String? status;
  dynamic createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.name,
    this.roasterGroupId,
    this.userType,
    this.depotId,
    this.cardNo,
    this.email,
    this.password,
    this.mobile,
    this.type,
    this.joiningDate,
    this.inactiveDate,
    this.bankAccount,
    this.bloodGroup,
    this.dateOfBirth,
    this.presentAddress,
    this.permanentAddress,
    this.emergencyContact,
    this.reference,
    this.gradeId,
    this.designationId,
    this.departmentId,
    this.requisitionId,
    this.candidateId,
    this.companyLocationId,
    this.workplaceId,
    this.workplaceType,
    this.notes,
    this.departmentHead,
    this.approvedBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        roasterGroupId: json["roaster_group_id"],
        userType: json["user_type"],
        depotId: json["depot_id"],
        cardNo: json["card_no"],
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
        type: json["type"],
        joiningDate: json["joining_date"] == null
            ? null
            : DateTime.parse(json["joining_date"]),
        inactiveDate: json["inactive_date"] == null
            ? null
            : DateTime.parse(json["inactive_date"]),
        bankAccount: json["bank_account"],
        bloodGroup: json["blood_group"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        emergencyContact: json["emergency_contact"],
        reference: json["reference"],
        gradeId: json["grade_id"],
        designationId: json["designation_id"],
        departmentId: json["department_id"],
        requisitionId: json["requisition_id"],
        candidateId: json["candidate_id"],
        companyLocationId: json["company_location_id"],
        workplaceId: json["workplace_id"],
        workplaceType: json["workplace_type"],
        notes: json["notes"],
        departmentHead: json["department_head"],
        approvedBy: json["approved_by"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roaster_group_id": roasterGroupId,
        "user_type": userType,
        "depot_id": depotId,
        "card_no": cardNo,
        "email": email,
        "password": password,
        "mobile": mobile,
        "type": type,
        "joining_date":
            "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "inactive_date":
            "${inactiveDate!.year.toString().padLeft(4, '0')}-${inactiveDate!.month.toString().padLeft(2, '0')}-${inactiveDate!.day.toString().padLeft(2, '0')}",
        "bank_account": bankAccount,
        "blood_group": bloodGroup,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "emergency_contact": emergencyContact,
        "reference": reference,
        "grade_id": gradeId,
        "designation_id": designationId,
        "department_id": departmentId,
        "requisition_id": requisitionId,
        "candidate_id": candidateId,
        "company_location_id": companyLocationId,
        "workplace_id": workplaceId,
        "workplace_type": workplaceType,
        "notes": notes,
        "department_head": departmentHead,
        "approved_by": approvedBy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
