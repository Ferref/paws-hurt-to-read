import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend/widgets/search_bar_widget.dart';

// TODO: My books will be displayed here ordered by last_opened
// TODO: If its not downloaded you can download the book to the device
// TODO: If its downloaded to the device you can open it for reading
// TODO: You can remove the book from device
// TODO: You can remove the book from (account + device)

// TODO: Implement search

class MyBooksView extends StatelessWidget {
  const MyBooksView({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // TODO: Implement search
          child: const SearchBarWidget(),
        ),
        SizedBox(
          height: 550,
          child: GridView.count(
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
            childAspectRatio: 0.625,
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            children: [
              Image.network('https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg'),
              Image.network('https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg'),
              Image.network('https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg'),
              Image.network('https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg'),
              Image.network('https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg'),
              Image.network('https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg'),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) => [const FileUploaderWidget()),]
              // );
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// TODO: Add pagination buttons

