import 'package:database_assignment/entity/contact.dart';
import 'package:database_assignment/entity/group.dart';
import 'package:database_assignment/store/contact.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

late ContactStore store;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  store = await ContactStore.init('${dir.path}/objectbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Groups',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  Group? selectedGroup;

  void _addContact() {
    if (nameCtrl.text.isEmpty || phoneCtrl.text.isEmpty || selectedGroup == null) {
      return;
    }

    final contact = Contact(name: nameCtrl.text, phone: phoneCtrl.text);
    store.addContact(contact, selectedGroup!);

    nameCtrl.clear();
    phoneCtrl.clear();
    selectedGroup = null;

    setState(() {});
  }

  void _deleteContact(int id) {
    store.deleteContact(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final contacts = store.getContacts();
    final groups = store.getGroups();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Contact List"
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(controller: nameCtrl,
                    decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: phoneCtrl,
                    decoration: InputDecoration(labelText: 'Phone')),
                DropdownButton<Group>(
                  hint: Text("Select Group"),
                  value: selectedGroup,
                  isExpanded: true,
                  items: groups.map((group) {
                    return DropdownMenuItem(
                        value: group, child: Text(group.name));
                  }).toList(),
                  onChanged: (Group? value) =>
                      setState(() => selectedGroup = value),
                ),
                ElevatedButton(
                    onPressed: _addContact, child: Text('Add Contact')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (_, i) {
                final contact = contacts[i];
                final group = contact.group.target;

                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(
                      '${contact.phone} • Group: ${group?.name ?? "None"}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteContact(contact.id),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}