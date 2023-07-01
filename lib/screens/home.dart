import 'dart:ffi';

import 'package:flutter/material.dart';
import 'add_service.dart';
import 'edit_service.dart';
import '../widgets/service_tile.dart';

// class _ServiceData {
//   String service = '';
//   String username = '';
//   String password = '';
//
//   _ServiceData(String service, String username, String password) {
//     this.service = service;
//     this.username = username;
//     this.password = password;
//   }
// }

// var item1 = _ServiceData('Bank of America', 'rbonagur', 'test');
// var item2 = _ServiceData('Fidelity', 'robert.bonagura', 'test');
// var item3 = _ServiceData('Netflix', 'rbon123', 'test');
// var item4 = _ServiceData('Disney+', 'rbonagur', 'test');
// var item5 = _ServiceData('PSE&G', 'rbonagur', 'test');

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static var serviceTiles = [
    ['Bank of America', 'rbonagur', Icons.payment],
    ['Fidelity', 'rbonagur', Icons.payment],
    ['Disney+', 'rbonagur', Icons.payment],
    ['Bank of America', 'rbonagur', Icons.payment],
    ['Fidelity', 'rbonagur', Icons.payment],
    ['Disney+', 'rbonagur', Icons.payment],
    ['Bank of America', 'rbonagur', Icons.payment],
    ['Fidelity', 'rbonagur', Icons.payment],
    ['Disney+', 'rbonagur', Icons.payment],
    ['Bank of America', 'rbonagur', Icons.payment],
    ['Fidelity', 'rbonagur', Icons.payment],
    ['Disney+', 'rbonagur', Icons.payment],
    ['Bank of America', 'rbonagur', Icons.payment],
    ['Fidelity', 'rbonagur', Icons.payment],
    ['Disney+', 'rbonagur', Icons.payment],
    ['Bank of America', 'rbonagur', Icons.payment],
    ['Fidelity', 'rbonagur', Icons.payment],
    ['Disney+', 'rbonagur', Icons.payment]
  ];

  bool isBankingChecked = false;
  bool isEntertainmentChecked = false;
  bool isOtherChecked = false;

  final TextEditingController inputController = TextEditingController();

  void _addItem(newItem){
    setState(() {
      serviceTiles.add([newItem[0], newItem[1], Icons.lightbulb]);
    });
  }

  void _submit(){

  }

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Password Keeper'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                var newItem = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddService()),
                );
                if (newItem != null) {
                  _addItem(newItem);
                }
              },
              tooltip: 'Add Service',
            ),
            const IconButton(
              icon: Icon(Icons.person),
              onPressed: null,
              tooltip: 'Edit Profile'
            )
          ],
        ),
        body: Column(
          children: [
            const Image(image: AssetImage('assets/images/flutter-logo.png')),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isBankingChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isBankingChecked = value!;
                    });
                  },
                ),
                const Text('Banking'),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isEntertainmentChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isEntertainmentChecked = value!;
                    });
                  },
                ),
                const Text('Entertainment'),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isOtherChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isOtherChecked = value!;
                    });
                  },
                ),
                const Text('Other'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: serviceTiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () async {
                        var updateItem = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditService(
                              data: serviceTiles[index]
                          )),
                        );
                        if (updateItem != null) {
                          ///Replace this with update method
                          _addItem(updateItem);
                        }
                      },
                      child: serviceTile(
                          serviceTiles[index][0].toString(),
                          serviceTiles[index][1].toString(),
                          Icons.payment
                      )
                  );
                })
            )
          ],
    )
    );
  }
}