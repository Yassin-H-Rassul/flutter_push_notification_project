import 'dart:convert';

import 'package:flutter/foundation.dart';

class GeneralUser {
  final String uid;
  final List<String> tokens;
  GeneralUser({
    required this.uid,
    required this.tokens,
  });

  GeneralUser copyWith({
    String? uid,
    List<String>? tokens,
  }) {
    return GeneralUser(
      uid: uid ?? this.uid,
      tokens: tokens ?? this.tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'tokens': tokens,
    };
  }

  factory GeneralUser.fromMap(Map<String, dynamic> map) {
    return GeneralUser(
      uid: map['uid'] ?? '',
      tokens: List<String>.from(map['tokens']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralUser.fromJson(String source) =>
      GeneralUser.fromMap(json.decode(source));

  @override
  String toString() => 'GeneralUser(uid: $uid, tokens: $tokens)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralUser &&
        other.uid == uid &&
        listEquals(other.tokens, tokens);
  }

  @override
  int get hashCode => uid.hashCode ^ tokens.hashCode;
}
