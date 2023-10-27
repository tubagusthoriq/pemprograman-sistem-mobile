import 'package:flutter/material.dart';

void main() {
  runApp(ContactListApp());
}

class Contact {
  String name;
  String phone;

  Contact(this.name, this.phone);
}

class ContactListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactList(),
    );
  }
}

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact> contacts = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void addContact(String name, String phone) {
    setState(() {
      contacts.add(Contact(name, phone));
      nameController.clear();
      phoneController.clear();
    });
  }

  void removeContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kontak'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phone),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeContact(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Tambah Kontak Baru'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nama'),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: 'Nomor Telepon'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      addContact(nameController.text, phoneController.text);
                      Navigator.of(context).pop();
                    },
                    child: Text('Simpan'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
