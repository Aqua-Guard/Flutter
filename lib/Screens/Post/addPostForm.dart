import 'dart:html' as html;

import 'package:aquaguard/Services/PostWebService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:showcaseview/showcaseview.dart';

class AddPostForm extends StatefulWidget {
  String token;
  final Function onPostUpdated;

  AddPostForm({Key? key, required this.token,required this.onPostUpdated}) : super(key: key);
  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  bool _isLoading = false;
  final _productController = TextEditingController();
  final _postDescriptionController = TextEditingController();
  late stt.SpeechToText _speechToText;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showMicInfoDialog());
  }

  html.File? _pickedImage;
  String? _imageDataUrl; //

  Future<void> _pickImage() async {
    final picker = html.FileUploadInputElement()..accept = 'image/*';
    picker.click();

    picker.onChange.listen((event) {
      final file = picker.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((loadEndEvent) {
        setState(() {
          _pickedImage = file;
          _imageDataUrl = reader.result as String;
        });
      });
    });
  }

  void _showMicInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Voice Typing'),
          content: Text(
              'Tap the microphone icon to use voice typing for your description.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _postDescriptionController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }

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
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Post', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xff00689B),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_splash_screen.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image, color: Color(0xff00689B)),
                        label: const Text('Add Image'),
                      ),
                      if (_pickedImage != null)
                        Container(
                          width: 300,
                          height: 300,
                          child: Image.network(_imageDataUrl!),
                        ),
                      const SizedBox(height: 16.0),
                      MyTextField(
                        myController: _postDescriptionController,
                        fieldName: "Post Description",
                        myIcon: Icons.article,
                        prefixIconColor: const Color(0xff00689B),
                        onMicTap: _listen,
                        isListening: _isListening,
                      ),
                      const SizedBox(height: 20.0),

                      const SizedBox(height: 16.0),
                      // i want to make this on the left side
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                // Set a flag to indicate that the operation is in progress
                                _isLoading = true;
                              });

                              try {
                                String? generatedDescription =
                                    await PostWebService()
                                        .generatePostDescriptionWithChatGPT(
                                            _postDescriptionController.text,
                                            widget.token);

                                if (generatedDescription == null) {
                                  // Show error message
                                  SnackBar snackBar = const SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.error, color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(
                                          'You must provide a prompt to generate a description',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Colors.red,
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  print('Generated description is null');
                                } else {
                                  // Update the _eventDescription with the generated result
                                  setState(() {
                                    _postDescriptionController.text =
                                        generatedDescription;
                                    _postDescriptionController.text =
                                        generatedDescription; // Update controller value
                                  });

                                  print(
                                      'Generated description: $_postDescriptionController');
                                }
                              } finally {
                                setState(() {
                                  // Set the flag back to false after the operation is complete
                                  _isLoading = false;
                                });
                              }

                              // Additional logic after the generation if needed
                            },
                            child: _isLoading
                                ? const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20.0, // Set the size
                                        width: 20.0, // Set the size
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Colors.blue), // Change the color
                                          strokeWidth:
                                              4.0, // Change the stroke width
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Generating...'),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Color(0xff00689B),
                                          BlendMode.srcIn,
                                        ),
                                        child: Image.asset(
                                          'ChatGPT-Logo.png',
                                          width: 40.0,
                                          height: 40.0,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Generate with ChatGPT'),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      myBtn(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function that returns OutlinedButton Widget also it pass data to Details Screen
  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(200, 50),
        primary: const Color(0xff00689B),
        side: BorderSide(color: const Color(0xff00689B)),
      ),
      onPressed: () async {
        if (_postDescriptionController.text.isEmpty || _pickedImage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Please add a description and an image.")),
          );
        } else {
          try {
            bool success = await PostWebService().addPost(
                widget.token, _postDescriptionController.text, _pickedImage!);
            if (success) {
              // Handle success, e.g., show success message or navigate
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Post added successfully")),
              );
             widget.onPostUpdated();
              Navigator.pop(context);
            } else {
              // Handle failure, e.g., show error message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to add post")),
              );
            }
          } catch (e) {
            print("Error adding post: $e");
            // Handle any errors here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error adding post: $e")),
            );
          }
        }
      },
      child: const Text(
        "Submit Form",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff00689B),
        ),
      ),
    );
  }
}

// Custom Stateless Widget Class that helps re-usability
class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
    this.onMicTap,
    required this.isListening,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final VoidCallback? onMicTap;
  final bool isListening;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(myIcon, color: prefixIconColor),
        suffixIcon: IconButton(
          icon: Icon(Icons.mic,
              color: isListening ? Colors.blueAccent : Colors.grey),
          onPressed: onMicTap,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff00689B)),
        ),
        labelStyle: const TextStyle(color: Color(0xff00689B)),
      ),
    );
  }
}
