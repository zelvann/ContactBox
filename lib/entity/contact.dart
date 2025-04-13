import 'package:database_assignment/entity/group.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Contact {
  @Id(assignable: true)
  int id;
  String name;
  String phone;
  final group = ToOne<Group>();
  Contact({this.id = 0, required this.name, required this.phone});
}