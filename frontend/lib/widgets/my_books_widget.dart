import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file_uploader_widget.dart';

class MyBooksWidget extends StatelessWidget {
  const MyBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: ImportButton(),
        ),

    );
  }
}

class ImportButton extends StatelessWidget {
  const ImportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Image.network(
            'https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg',
            height: 200,
            width: 200, )
          ),
        Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                FileUploaderWidget();  
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Import Books',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
