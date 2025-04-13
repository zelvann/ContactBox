import 'package:database_assignment/entity/contact.dart';
import 'package:database_assignment/entity/group.dart';
import 'package:database_assignment/objectbox.g.dart';

class ContactStore {
  late final Store store;
  late final Box<Contact> contactBox;
  late final Box<Group> groupBox;

  ContactStore._create(this.store) {
    contactBox = store.box<Contact>();
    groupBox = store.box<Group>();

    if (groupBox.isEmpty()) {
      groupBox.putMany([
        Group(name: 'Family'),
        Group(name: 'Friends'),
        Group(name: 'Work'),
      ]);
    }
  }

  static Future<ContactStore> init(String dir) async {
    final store = await openStore(directory: dir);
    return ContactStore._create(store);
  }

  List<Contact> getContacts() => contactBox.getAll();
  void addContact(Contact contact, Group group) {
    contact.group.target = group;
    contactBox.put(contact);
  }

  void deleteContact(int id) {
    contactBox.remove(id);
  }

  List<Group> getGroups() => groupBox.getAll();
}