import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/application/laboratory_form_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/image.dart';

class PDFShowerWidget extends StatelessWidget {
  const PDFShowerWidget({
    required this.formProvider,
    super.key,
  });
  final LaboratoryFormProvider formProvider;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      width: 88,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(BImage.imagePDF)),
          Positioned(
              top: -14,
              right: -14,
              child: IconButton(
                  onPressed: () {
                    formProvider.deletePDF();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    size: 24,
                    color: Colors.red,
                  ))),
        ],
      ),
    );
  }
}
