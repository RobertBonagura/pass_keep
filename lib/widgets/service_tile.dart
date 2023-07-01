import 'package:flutter/material.dart';

ListTile serviceTile(String service, String username, IconData icon) {
  return ListTile(
    title: Text(service,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(username),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}