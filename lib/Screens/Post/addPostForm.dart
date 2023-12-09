import 'package:aquaguard/Screens/Post/detailsAddForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostForm extends StatefulWidget {
  const AddPostForm({Key? key}) : super(key: key);
  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final _productController = TextEditingController();
  final _postDescriptionController = TextEditingController();
  @override
  void dispose() {
    _productController.dispose();
    _postDescriptionController.dispose();
    super.dispose();
  }

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
            title: const Text('Add Post',style: TextStyle( color: Colors.white )),

            backgroundColor: Color(0xff00689B),

            elevation: 0,
          ),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  MyTextField(
                      myController: _postDescriptionController,
                      fieldName: "Post Description",
                      myIcon: Icons.article,
                      prefixIconColor: const Color(0xff00689B)),
                  const SizedBox(height: 10.0),
                  //Use to add space between Textfields
                  
                  myBtn(context),
                ],
              ),
            )));
  }

  //Function that returns OutlinedButton Widget also it pass data to Details Screen
  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailsAddForm(
              productName: _productController.text,
              postDescription: _postDescriptionController.text,
            );
          }),
        );
      },
      child: Text(
        "Submit Form".toUpperCase(),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: const Color(0xff00689B)),
      ),
    );
  }
}

//Custom STateless WIdget Class that helps re-usability
// You can learn it in Tutorial (2.13) Custom Widget in Flutter
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  });
  final TextEditingController myController;
  String fieldName;
  final IconData myIcon;
  Color prefixIconColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(myIcon, color: prefixIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xff00689B)),
          ),
          labelStyle: const TextStyle(color: const Color(0xff00689B))),
    );
  }
}
