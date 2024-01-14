import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Define a data class for the image data
class ImageData {
  final String imagePath;
  final String name;
  final String description;

  ImageData({
    required this.imagePath,
    required this.name,
    required this.description,
  });
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a list of ImageData objects
    List<ImageData> imageDataList = [
      ImageData(
        imagePath: "assets/sponsor/1.png",
        name: "Image 1",
        description: "This is the first image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/2.png",
        name: "Image 2",
        description: "This is the second image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/3.png",
        name: "Image 2",
        description: "This is the second image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/4.jpg",
        name: "Image 2",
        description: "This is the second image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/5.png",
        name: "Image 2",
        description: "This is the second image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/6.png",
        name: "Image 2",
        description: "This is the second image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/7.png",
        name: "Image 2",
        description: "This is the second image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/8.png",
        name: "Image 2",
        description: "This is the second image.",
      ),
      ImageData(
        imagePath: "assets/sponsor/9.png",
        name: "Image 2",
        description: "This is the second image.",
      ),
      // add more images here...
    ];

    final user = FirebaseAuth.instance.currentUser!;

    void signUserOut() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            Text("${user.displayName!} (${user.email!})"),
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body:

            // Create a ListView widget with the list of ImageData objects
            ListView.separated(
                itemCount:
                    imageDataList.length, // Set the number of items in the list
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(), // Add a divider between each item in the list
                itemBuilder: (BuildContext context, int index) {
                  final imageData = imageDataList[
                      index]; // Get the ImageData object at the current index
                  return Card(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit
                              .contain, //I assumed you want to occupy the entire space of the card
                          image: AssetImage(
                            imageData.imagePath,
                          ),
                        ),
                      ),
                      child: ListTile(
                          // leading: Image.asset(imageData
                          //     .imagePath), // Display the image on the left side of the ListTile
                          // title: Text(imageData
                          //     .name), // Display the name as the title of the ListTile
                          // subtitle: Text(imageData
                          //     .description), // Display the description as the subtitle of the ListTile
                          ),
                    ),
                  );
                }));
  }
}
