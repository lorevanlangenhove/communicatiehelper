import 'package:flutter/material.dart';
import 'package:communicatiehelper/constants.dart';

class AddDairyFragment extends StatefulWidget {
  static String id = 'add_dairy_fragment_page';

  @override
  State<AddDairyFragment> createState() => _AddDairyFragmentState();
}

class _AddDairyFragmentState extends State<AddDairyFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText: 'Titel'),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            decoration: kTextFieldDecoration.copyWith(
                hintText: 'Wat is er vandaag gebeurd?'),
          ),
          const SizedBox(
            height: 50.0,
          ),
          SizedBox(
            height: 50.0,
            width: 200.0,
            child: TextButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              onPressed: () {
                //alert
              },
              label: Text(
                'Voeg foto toe',
                style: TextStyle(fontSize: 20.0),
              ),
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
                width: 200.0,
                child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  onPressed: () {
                    //alert
                  },
                  label: Text(
                    'Opslaan',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
                width: 200.0,
                child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: () {
                    //alert
                  },
                  label: Text(
                    'Annuleren',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
