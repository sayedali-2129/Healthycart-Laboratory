// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:healthy_cart_laboratory/core/custom/app_bar/custom_appbar_curve.dart';
// import 'package:healthy_cart_laboratory/core/custom/confirm_alertbox/confirm_delete_widget.dart';
// import 'package:healthy_cart_laboratory/core/custom/lottie/loading_lottie.dart';
// import 'package:healthy_cart_laboratory/core/services/easy_navigation.dart';
// import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
// import 'package:healthy_cart_laboratory/features/hospital_profile/application/profile_provider.dart';
// import 'package:healthy_cart_laboratory/features/hospital_profile/presentation/widget/doctor_list_profile/doctor_list.dart';
// import 'package:healthy_cart_laboratory/features/hospital_profile/presentation/widget/profile_header_widget.dart';
// import 'package:healthy_cart_laboratory/features/hospital_profile/presentation/widget/profile_main_container_widget.dart';
// import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<AuthenticationProvider, ProfileProvider>(
//         builder: (context, authenticationProvider, profileProvider, _) {
//       return SizedBox(
//         height: double.infinity,
//         width: double.infinity,
//         child: Column(
//           children: [
//             const CustomCurveAppBarWidget(),
//             const Gap(6),
//             const ProfileHeaderWidget(),
//             const Gap(8),
//             ProfileMainContainer(
//               text: 'Hospital On / Off',
//               sideChild: LiteRollingSwitch(
//                 value: authenticationProvider.hospitalDataFetched?.isActive ??
//                     false,
//                 width: 80,
//                 textOn: 'On',
//                 textOff: 'Off',
//                 colorOff: Colors.grey.shade400,
//                 colorOn: BColors.mainlightColor,
//                 iconOff: Icons.block_rounded,
//                 iconOn: Icons.power_settings_new,
//                 animationDuration: const Duration(milliseconds: 300),
//                 onChanged: (bool ishospitalActive) {
//                   profileProvider.setActiveHospital(
//                     ishospitalActive: ishospitalActive,
//                   );
//                 },
//                 onDoubleTap: () {},
//                 onSwipe: () {},
//                 onTap: () {},
//               ),
//             ),
//             const Gap(4),
//             GestureDetector(
//               onTap: () {
//                 EasyNavigation.push(
//                     context: context, page: const DoctorProfileList());
//               },
//               child: const ProfileMainContainer(
//                   text: 'Doctors List',
//                   sideChild: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_forward_ios),
//                   )),
//             ),
//             const Gap(4),
//             GestureDetector(
//               onTap: () {},
//               child: const ProfileMainContainer(
//                   text: 'Bookings & History',
//                   sideChild: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_forward_ios),
//                   )),
//             ),
//             const Gap(4),
//             GestureDetector(
//               onTap: () {},
//               child: const ProfileMainContainer(
//                   text: 'Payment History',
//                   sideChild: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_forward_ios),
//                   )),
//             ),
//             const Gap(4),
//             GestureDetector(
//               onTap: () {
//                 ConfirmAlertBoxWidget.showAlertConfirmBox(
//                     context: context,
//                     confirmButtonTap: () {
//                       LoadingLottie.showLoading(
//                           context: context, text: 'Logging Out');
//                       authenticationProvider.hospitalLogOut(context: context);
//                     },
//                     titleText: 'Confirm to Log Out',
//                     subText: 'Are you sure to Log Out ?');
//               },
//               child: const ProfileMainContainer(
//                   text: 'Log Out',
//                   sideChild: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(Icons.logout),
//                   )),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
