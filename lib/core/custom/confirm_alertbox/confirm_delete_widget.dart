import 'package:flutter/material.dart';


class ConfirmAlertBoxWidget{

 static void showAlertConfirmBox({required BuildContext context, required VoidCallback confirmButtonTap, required String titleText, required String subText}){
    showDialog(
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: 260,
                    height: 300,
                    child: AlertDialog(
                      title: Text( titleText ,
                          style: Theme.of(context).textTheme.bodyLarge),
                      content: Text(subText,
                          style: Theme.of(context).textTheme.labelLarge),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
                        ElevatedButton(
                          onPressed: () {
                            confirmButtonTap.call();

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text('Yes',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}