import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../contact_details.dart';
import '../models/contact.dart';
import '../contact_list.dart';
import '../presenters/contacts_presenter.dart';
import '../views/base_view.dart';
import 'views/base_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements BaseView {
  late ContactsPresenter contactsPresenter;

  @override
  void initState() {
    super.initState();
    contactsPresenter = ContactsPresenter.withView(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment = Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: const <Widget>[
            Text(
              'Contacts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openAddUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ContactDialog().build(context, this, false, null),
    );

    screenUpdate();
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.group_add,
          color: Colors.white,
        ),
        onPressed: _openAddUserDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _buildTitle(context),
        actions: _buildActions(),
      ),
      body: FutureBuilder<List<Contact>>(
        future: contactsPresenter.getAll(),
        builder: (context, snapshot) {
          print('Snapshot data: ${snapshot.data}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Display data if available
            return ContactList(snapshot.data ?? [], contactsPresenter);
          } else {
            // Show a message if no data is available
            return Center(child: Text('No contacts found.'));
          }
        },
      ),
    );
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}
