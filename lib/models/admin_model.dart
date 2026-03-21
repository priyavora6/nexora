class AdminModel {
  final String uid;
  final String email;
  final String role;

  AdminModel({
    required this.uid,
    required this.email,
    this.role = 'admin',
  });

  factory AdminModel.fromMap(String uid, Map<String, dynamic> data) {
    return AdminModel(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? 'admin',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
    };
  }
}