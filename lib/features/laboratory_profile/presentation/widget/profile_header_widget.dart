import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/core/services/easy_navigation.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/presentation/laboratory_form.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (context, authProviderHospitalDetails, _) {
      return SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ClipRRect(
                  child: CustomCachedNetworkImage(
                      image: authProviderHospitalDetails
                              .labFetchlDataFetched?.image ??
                          ''),
                ),
              ),
            ),
            Positioned.fill(
                child: Container(
              color: Colors.white.withOpacity(.4),
            )),
            Positioned(
              bottom: 40,
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  border: Border.all(color: BColors.darkblue),
                  color: BColors.lightGrey.withOpacity(.7),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 16, bottom: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (authProviderHospitalDetails
                                    .labFetchlDataFetched?.laboratoryName ??
                                'Unkown Hospital Name')
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20,
                            color: BColors.darkblue,
                            fontWeight: FontWeight.w700),
                        maxLines: 4,
                      ),
                      Text(
                        '${'Proprietor :'} ${authProviderHospitalDetails.labFetchlDataFetched?.ownerName}',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: BColors.darkblue,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                right: 16,
                top: 16,
                child: InkWell(
                  onTap: () {
                    EasyNavigation.push(
                        context: context,
                        page: LaboratoryFormScreen(
                          laboratoryModel:
                              authProviderHospitalDetails.labFetchlDataFetched,
                          phoneNo: authProviderHospitalDetails
                              .labFetchlDataFetched?.phoneNo,
                        ));
                  },
                  child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          border: Border.all(color: BColors.darkblue),
                          color: BColors.lightGrey.withOpacity(.5),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Icon(
                        Icons.edit_square,
                        color: BColors.darkblue,
                      ))),
                ))
          ],
        ),
      );
    });
  }
}
