import 'package:firebase_auth/firebase_auth.dart';

class UserAndDate {
  final DateTime date;
  final User user;

  UserAndDate(this.date, this.user);
}
