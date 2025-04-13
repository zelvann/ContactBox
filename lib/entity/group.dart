import 'package:objectbox/objectbox.dart';

@Entity()
class Group {
  int id;
  String name;

  Group({this.id = 0, required this.name});
}