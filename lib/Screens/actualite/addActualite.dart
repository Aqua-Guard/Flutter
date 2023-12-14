import 'package:aquaguard/Models/partenaire.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  String _newsContent = '';
  String? _selectedOrganizer;

  late XFile? _pickedImage = null;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage!;
      });
    }
  }

  List<Partenaire> partenairesData = [];

  @override
  void initState() {
    super.initState();

    EventWebService().fetchPartenaires().then((partenaires) {
      setState(() {
        partenairesData = partenaires;
      });
    }).catchError((error) {
      print('Error fetching partenaires: $error');
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
                          if (_pickedImage != null)
                            Container(
                              width: 100,
                              height: 100,
                              child: Image.network(_pickedImage!.path),
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
                              labelText: 'News Content',
                            ),
                            maxLines: 3,
                            
                            onSaved: (value) {
                              _newsContent = value ?? '';
                            },
                          ),
                          const SizedBox(height: 16.0),
                          DropdownButtonFormField<String>(
                            value: _selectedOrganizer,
                            onChanged: (value) {
                              setState(() {
                                _selectedOrganizer = value;
                              });
                            },
                            items: partenairesData
                                .map((partenaire) => DropdownMenuItem(
                                      value: partenaire.id,
                                      child: Text(
                                          '${partenaire.firstName} ${partenaire.LastName}'),
                                    ))
                                .toList(),
                            decoration: const InputDecoration(
                              labelText: 'Organizer',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // Validate form data
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                  
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
