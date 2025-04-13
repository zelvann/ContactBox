import 'package:objectbox/objectbox.dart';

@Entity()
class Group {
  @Id(assignable: true)
  int id;
  String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Group &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
  Group({this.id = 0, required this.name});
}