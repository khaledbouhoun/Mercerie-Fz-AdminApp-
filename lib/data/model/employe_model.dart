class EmployeModel {
  int? employeeId;
  String? employeeName;
  String? employeePhone;
  int? employeeType;
  int? employeeActive;
  String? employeeDate;

  EmployeModel({
    this.employeeId,
    this.employeeName,
    this.employeePhone,
    this.employeeType,
    this.employeeActive,
    this.employeeDate,
  });

  EmployeModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeePhone = json['employee_phone'];
    employeeType = json['employee_type'];
    employeeActive = json['employee_active'];
    employeeDate = json['employee_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['employee_phone'] = employeePhone;
    data['employee_type'] = employeeType;
    data['employee_active'] = employeeActive;
    data['employee_date'] = employeeDate;
    return data;
  }
}
