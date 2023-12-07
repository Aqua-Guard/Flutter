import 'package:aquaguard/Screens/Post/oneSinglePost.dart';
import 'package:flutter/material.dart';

class DetailsAddForm extends StatelessWidget {
  DetailsAddForm(
      {Key? key, required this.productName, required this.postDescription})
      : super(key: key);

  String productName, postDescription;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          // This will change the drawer icon color
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('My New Post Shape',style: TextStyle( color: Colors.white )),

            backgroundColor: Color(0xff00689B),

            elevation: 0,
          ),

         body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background_splash_screen.png'),
                    fit: BoxFit
                        .cover, // This will fill the background of the container, you can change it as needed.
                  ),
                ),
              ),
             
               
                
                    // Expanded should be a direct child of Column
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:OneSinglePost( postDescription: postDescription)
                      ),
                   
                  
                
              
            ],
          ),
        
        ));
  }
}
