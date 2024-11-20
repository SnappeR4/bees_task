import 'package:hive/hive.dart';

part 'complaint.g.dart';

@HiveType(typeId: 0) // Ensure this is a unique ID
class Complaint {
  @HiveField(0)
  String type;

  @HiveField(1)
  String date;

  @HiveField(2)
  String description;

  @HiveField(3)
  String filePath;

  Complaint({
    required this.type,
    required this.date,
    required this.description,
    required this.filePath,
  });
}
