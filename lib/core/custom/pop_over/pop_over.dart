import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/confirm_alertbox/confirm_delete_widget.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:popover/popover.dart';

//list of edit and delete of popover
class ListItems extends StatelessWidget {
  const ListItems(
      {super.key, required this.editButton, required this.deleteButton});
  final void Function() editButton;
  final void Function() deleteButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(4),
        children: [
          InkWell(
            onTap: () {
              editButton.call();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text('Edit',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.white))),
              ),
            ),
          ),
          const Gap(4),
          InkWell(
            onTap: () async {
              ///delete confirm alert box
              ConfirmAlertBoxWidget.showAlertConfirmBox(
                  context: context,
                  confirmButtonTap: deleteButton,
                  titleText: 'Confirm to delete',
                  subText: "Are you sure you want to delete?");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 72,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text('Delete',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.white))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//pop three dot button for edit and delete
class PopOverEditDelete extends StatelessWidget {
  const PopOverEditDelete(
      {super.key,
      required this.editButton,
      required this.deleteButton,
      this.iconColor});
  final void Function() editButton;
  final void Function() deleteButton;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
            context: context,
            bodyBuilder: (context) => ListItems(
                  editButton: () {
                    Navigator.pop(context);
                    editButton.call();
                  },
                  deleteButton: () {
                    Navigator.pop(context);
                    deleteButton.call();
                  },
                ),
            direction: PopoverDirection.bottom,
            radius: 12,
            width: 160,
            height: 144,
            arrowHeight: 15,
            arrowWidth: 30,
            backgroundColor: const Color(0xFF11334E));
      },
    );
  }
}
