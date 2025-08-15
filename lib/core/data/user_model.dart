import 'package:hive/hive.dart';
import 'package:login_signin/core/remote/api_keys.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  final Map<String, dynamic>? address;
  @HiveField(1)
  final int? id;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final Map<String, dynamic> name;
  @HiveField(6)
  final String phone;
  @HiveField(7)
  final int v;
  const User({
    this.address,
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.phone,
    this.v = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      address: json[ApiKeys.address],
      id: json[ApiKeys.id],
      username: json[ApiKeys.username],
      password: json[ApiKeys.password],
      email: json[ApiKeys.email],
      name: {
        'firstname': json[ApiKeys.name][ApiKeys.firstname] as String,
        'lastname': json[ApiKeys.name][ApiKeys.lastname] as String,
      },
      phone: json[ApiKeys.phone],
      v: json[ApiKeys.v],
    );
  }

  Map<String, dynamic> toJson() => {
    ApiKeys.id: id,
    ApiKeys.username: username,
    ApiKeys.password: password,
    ApiKeys.name: name,
    ApiKeys.phone: phone,
    ApiKeys.email: email,
    ApiKeys.v: v,
  };

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    Map<String, dynamic>? name,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  String get displayName {
    final first = name['firstname'];
    final last = name['lastname'];
    final full = '$first $last'.trim();
    return full;
  }
}
