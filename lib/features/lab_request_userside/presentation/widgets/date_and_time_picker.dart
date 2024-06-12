import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/button_widget.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class DateAndTimePick extends StatelessWidget {
  const DateAndTimePick({
    super.key,
    this.onSave,
  });
  final void Function()? onSave;

  @override
  Widget build(BuildContext context) {
    return Consumer<LabOrdersProvider>(builder: (context, ordersProvider, _) {
      return PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            ordersProvider.dateController.clear();
            ordersProvider.selectedTimeSlot1 = null;
            ordersProvider.selectedTimeSlot2 = null;
          }
        },
        child: AlertDialog(
          backgroundColor: BColors.white,
          title: const Text(
            'Select Date & Time',
            style: TextStyle(fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45,
                child: TextField(
                  onTap: () async {
                    final DateTime? date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 60)));
                    final formattedDate =
                        DateFormat('dd/MM/yyyy').format(date!);
                    ordersProvider.dateController.text = formattedDate;
                  },
                  readOnly: true,
                  style: const TextStyle(
                      color: BColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  controller: ordersProvider.dateController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 5, left: 8),
                    hintText: 'Select Date',
                    hintStyle: TextStyle(
                        color: BColors.black.withOpacity(0.5), fontSize: 14),
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(width: 0.5, color: BColors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(width: 0.5, color: BColors.black)),
                  ),
                ),
              ),
              const Gap(8),
              TimePickerSpinnerPopUp(
                cancelTextStyle: Theme.of(context).textTheme.labelLarge,
                confirmTextStyle: Theme.of(context).textTheme.labelLarge,
                iconSize: 24,
                timeFormat: 'hh:mm a',
                use24hFormat: false,
                mode: CupertinoDatePickerMode.time,
                onChange: (dateTime) {
                  ordersProvider.selectedTimeSlot1 =
                      DateFormat.jm().format(dateTime);
                },
              ),
              const Gap(8),
              Text(
                'To',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Gap(8),
              TimePickerSpinnerPopUp(
                cancelTextStyle: Theme.of(context).textTheme.labelLarge,
                confirmTextStyle: Theme.of(context).textTheme.labelLarge,
                iconSize: 24,
                timeFormat: 'hh:mm a',
                use24hFormat: false,
                mode: CupertinoDatePickerMode.time,
                onChange: (dateTime) {
                  ordersProvider.selectedTimeSlot2 =
                      DateFormat.jm().format(dateTime);
                },
              ),
              const Gap(12),
              ButtonWidget(
                buttonHeight: 40,
                buttonWidth: 100,
                buttonColor: BColors.darkblue,
                buttonWidget: const Text(
                  'Save',
                  style: TextStyle(color: BColors.white),
                ),
                onPressed: onSave,
              )
            ],
          ),
        ),
      );
    });
  }
}
