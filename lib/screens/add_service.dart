import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

enum ServiceGroup {banking, entertainment, other}

class _AddServiceState extends State<AddService> {

  ServiceGroup? _group = ServiceGroup.banking;

  final TextEditingController inputController = TextEditingController();
  static var prompt = 'What is the name of the service you are adding?';
  static var hintText = 'i.e. Bank of America, or Netflix';
  static var obscureText = false;
  static var service = '';
  static var username = '';
  static var password = '';

  bool isBankingChecked = false;
  bool isEntertainmentChecked = false;
  bool isOtherChecked = false;

  void _submit() {
    setState(() {
      if (prompt == 'What is the name of the service you are adding?') {
        _AddServiceState.prompt = 'What is your username for this service?';
        _AddServiceState.hintText = '';
        _AddServiceState.service = inputController.text;
      } else if (prompt == 'What is your username for this service?') {
        _AddServiceState.prompt = 'Enter a password to save for this service.';
        _AddServiceState.obscureText = true;
        _AddServiceState.username = inputController.text;
      } else if (prompt == 'Enter a password to save for this service.') {
        _AddServiceState.prompt = 'What is the name of the service you are adding?';
        _AddServiceState.hintText = 'i.e. Bank of America, or Netflix';
        _AddServiceState.obscureText = false;
        _AddServiceState.password = inputController.text;
        Navigator.pop(context, [
          _AddServiceState.service,
          _AddServiceState.username,
          _AddServiceState.password
        ]);
      }
    });
  }

  Widget getServiceTypeWidget(){
    if (prompt == 'What is the name of the service you are adding?'){
      return Column(
        children: [
          ListTile(
              title: const Text('Banking'),
              leading: Radio<ServiceGroup>(
                value: ServiceGroup.banking,
                groupValue: _group,
                onChanged: (ServiceGroup? value) {
                  setState(() {
                    _group = value;
                  });
                }
              ),
          ),
          ListTile(
            title: const Text('Entertainment'),
            leading: Radio<ServiceGroup>(
                value: ServiceGroup.entertainment,
                groupValue: _group,
                onChanged: (ServiceGroup? value) {
                  setState(() {
                    _group = value;
                  });
                }
            ),
          ),
          ListTile(
            title: const Text('Other'),
            leading: Radio<ServiceGroup>(
                value: ServiceGroup.other,
                groupValue: _group,
                onChanged: (ServiceGroup? value) {
                  setState(() {
                    _group = value;
                  });
                }
            ),
          )
        ],
      );
    }
    return const SizedBox.shrink();
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
          title: const Text('Add a service'),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
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
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(prompt,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28)
                  ),
                ),
                const Image(image: AssetImage('assets/images/flutter-logo.png')),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: inputController,
                    onEditingComplete: _submit,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      icon: IconButton(
                          onPressed: _submit,
                          icon: const Icon(Icons.send)
                      ),
                      hintText: hintText,
                      counterText: '0 characters',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                getServiceTypeWidget()
              ])
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }
}