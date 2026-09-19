class AuditLogModel {
  final int id;
  final String action;
  final String? entityType;
  final String? entityId;
  final String? details;
  final String? performedByAdminId;
  final DateTime createdDate;

  const AuditLogModel({
    required this.id,
    required this.action,
    this.entityType,
    this.entityId,
    this.details,
    this.performedByAdminId,
    required this.createdDate,
  });

  factory AuditLogModel.fromJson(Map<String, dynamic> json) {
    return AuditLogModel(
      id: json['id'] as int? ?? 0,
      action: json['action'] as String? ?? '',
      entityType: json['entityType'] as String?,
      entityId: json['entityId'] as String?,
      details: json['details'] as String?,
      performedByAdminId: json['performedByAdminId'] as String?,
      createdDate:
          DateTime.tryParse(json['createdDate'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
    );
  }
}
