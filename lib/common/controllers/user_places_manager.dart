import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

const uuid = Uuid();

class UserPlacesManager {
  UserPlacesManager(
      {required this.description, required this.date, required this.location})
      : id = uuid.v4();

  final String id;
  final String location;
  final String description;
  final DateTime date;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
