import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdfScreen extends StatefulWidget {
  final String pdfUrl;
  final String title;
  final Color headingColor;
  const ViewPdfScreen(
      {super.key,
      required this.pdfUrl,
      required this.title,
      required this.headingColor});

  @override
  State<ViewPdfScreen> createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 22,
            )),
        leadingWidth: 36,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.title,
          style: TextStyle(
            color: widget.headingColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl,
      ),
    );
  }
}
