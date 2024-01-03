import 'package:aquaguard/Services/ActualiteWebService.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class AddNews extends StatefulWidget {
  String token;
  AddNews({Key? key, required this.token}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsFormState();
}


class _AddNewsFormState extends State<AddNews> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables to store form data
  String _newsTitle = '';
  String _newsDescription = '';
    String _newstext = '';



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
          title: const Text(
            'Add News',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff00689B),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.image,
                                color: Color(0xff00689B)),
                            label: const Text('Add Image'),
                          ),
                          if (_imageDataUrl != null)
                            Container(
                              width: 100,
                              height: 100,
                              child: Image.network(_imageDataUrl!),
                            ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'News Title',
                            ),
                           
                            onSaved: (value) {
                              _newsTitle = value ?? '';
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'News Description',
                            ),
                            maxLines: 3,
                            
                            onSaved: (value) {
                              _newsDescription = value ?? '';
                            },
                          ),
                        const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'News Text',
                            ),
                            maxLines: 3,
                            
                            onSaved: (value) {
                              _newstext = value ?? '';
                            },
                          ),
                          const SizedBox(height: 16.0),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                                                  if (_formKey.currentState?.validate() ??
                                        false) {
                                      _formKey.currentState?.save();
                                      await ActualiteWebService().addActualite(
                                        token: widget.token,
                                        title: _newsTitle,
                                        description: _newsDescription,
                                        text: _newstext,
                                        fileimage: _pickedImage!,
                                        context: context,
                                      );

                                      Navigator.pop(context);
                                    }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff00689B),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text('Submit',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
