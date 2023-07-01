import 'package:flutter/material.dart';

class EditService extends StatefulWidget {
  const EditService({Key? key, required this.data}) : super(key: key);
  final List<Object> data;
  
  @override
  State<EditService> createState() => _EditServiceState();
}
enum ServiceGroup {banking, entertainment, other}

// Define a corresponding State class.
// This class holds data related to the form.
class _EditServiceState extends State<EditService> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  ServiceGroup? _group = ServiceGroup.banking;

  final TextEditingController serviceInputController = TextEditingController();
  final TextEditingController usernameInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  static var service = '';
  static var username = '';
  static var password = '';

  bool isBankingChecked = false;
  bool isEntertainmentChecked = false;
  bool isOtherChecked = false;

  void _edit(){
    setState(() {
      _EditServiceState.service = serviceInputController.text;
      _EditServiceState.username = usernameInputController.text;
      _EditServiceState.password = passwordInputController.text;
      Navigator.pop(context, [
        _EditServiceState.service,
        _EditServiceState.username,
        _EditServiceState.password
      ]);
    });
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
        title: Text('Edit ${widget.data[0]}')
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Service Name'),
            TextField(
              controller: serviceInputController,
              decoration: InputDecoration(
                  hintText: widget.data[0].toString()
              ),
            ),
            const Text('Username'),
            TextField(
              controller: usernameInputController,
              decoration: InputDecoration(
                  hintText: widget.data[1].toString()
              ),
            ),
            const Text('Password'),
            TextField(
              controller: passwordInputController,
              decoration: const InputDecoration(
                  hintText: 'enter new password'
              ),
            ),
            const Image(image: AssetImage('assets/images/flutter-logo.png')),
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
            ),
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
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _edit()),
        tooltip: 'Save changes',
        child: const Icon(Icons.add),
      ),
    );
  }
}