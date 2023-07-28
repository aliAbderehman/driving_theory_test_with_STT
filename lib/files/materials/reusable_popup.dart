import 'package:abel_proj_01/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import '../screens/settings_screen.dart';

class ReusablePopUp extends StatelessWidget {
  const ReusablePopUp({super.key, this.rebuild});

  final Function? rebuild;

  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        case 'Home':
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route route) => false);
          // Navigator.pushNamed(context, '/');
          break;
        case 'Settings':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Settings()),
          );
          break;
        case 'Exit':
          SystemNavigator.pop();
          break;
      }
    }

    return PopupMenuButton<String>(
      onSelected: handleClick,
      itemBuilder: (BuildContext context) {
        return {'Home', 'Settings', 'Exit'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }).toList();
      },
    );
  }
}
