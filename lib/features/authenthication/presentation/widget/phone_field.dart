import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneField extends StatelessWidget {
  const PhoneField(
      {super.key,
      required this.phoneNumberController,
      required this.countryCode});

  final TextEditingController phoneNumberController;
  final void Function(String) countryCode;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      disableLengthCheck: true,
      showCountryFlag: false,
      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: BColors.textWhite,
        countryNameStyle: Theme.of(context).textTheme.labelLarge,
        searchFieldPadding: const EdgeInsets.all(8),
      ),
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: (value) {
        countryCode(value.countryCode);
      },
      controller: phoneNumberController,
      initialCountryCode: 'IN',
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
        filled: true,
        fillColor: BColors.textWhite,
        hintText: "Number goes here",
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
