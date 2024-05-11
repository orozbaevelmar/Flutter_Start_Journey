import 'package:flutter/material.dart';
import 'dart:io';

class Settings_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 70,
              alignment: Alignment.center,
              child: ListTile(
                leading: Icon(
                  Icons.person_pin,
                  size: 40,
                ),
                //horizontalTitleGap: 30,
                title: Text(
                  "Orozbaev Elmarbek",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {},
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.dark_mode_outlined,
                  size: 25,
                ),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                //trailing:

                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.language_outlined,
                  size: 25,
                ),
                title: Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 30,
                ),
                title: Text(
                  'Close App',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      content: Text(
                        'Do you want to exit an App?',
                        style: TextStyle(
                          fontSize: 21,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            "No  ",
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Yes  ',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                          onPressed: () {
                            exit(0);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
