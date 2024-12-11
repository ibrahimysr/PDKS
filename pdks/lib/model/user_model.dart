class UserModel {
  final String id;
  final String email;
  final String adSoyad;
  final String telefonNumarasi;
  final String birim;
  final String gorev;
  final List<String> izinler;
  final List<String> mesai;
  final String role;
  final String profileImageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.adSoyad,
    required this.telefonNumarasi,
    required this.birim,
    required this.gorev,
    required this.izinler,
    required this.mesai,
    required this.role,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['Email'] ?? '',
      adSoyad: json['Ad_Soyad'] ?? '',
      telefonNumarasi: json['Telefon Numarası'] ?? '',
      birim: json['Birim'] ?? '',
      gorev: json['Görev'] ?? '',
      izinler: List<String>.from(json['İzinler'] ?? []),
      mesai: List<String>.from(json['Mesai'] ?? []),
      role: json['Role'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }
}
