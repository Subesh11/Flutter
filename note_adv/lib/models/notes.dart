import 'package:isar/isar.dart';
part 'notes.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
  late String? subtext;
  // String input = "01/09/2025 10:53 PM";
  // DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");
  // DateTime get dt => format.parse(input);
  late DateTime datetime; // <-- Missing semicolon here
}
