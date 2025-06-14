import 'package:flutter/material.dart';
import 'package:start_journey/old_stuffs/u_presentation/screen/account/account.dart';
import 'dart:io';

import 'package:start_journey/old_stuffs/utils/constants/navigator_custom.dart';

class Settings_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _buildAccount(context),
            _buildListTile(
              onTap: () => Go.to(context, AccountScreen()),
              iconData: Icons.person_outline,
              text: 'Account',
            ),
            _buildListTile(
                iconData: Icons.dark_mode_outlined, text: 'Dark Mode'),
            _buildListTile(iconData: Icons.language_outlined, text: 'Language'),
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
                          onPressed: () => exit(0),
                        ),
                      ],
                    );
                  },
                ),
                leading: Icon(
                  Icons.exit_to_app,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    VoidCallback? onTap,
    required IconData iconData,
    required String text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: Icon(
            iconData,
            size: 25,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildAccount(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: const Icon(
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
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {},
      ),
    );
  }
}
