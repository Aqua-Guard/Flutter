import 'package:aquaguard/Models/partenaire.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class AddEventForm extends StatefulWidget {
  String token;
  AddEventForm({Key? key, required this.token}) : super(key: key);

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  // Variables to store form data
  String _eventName = '';
  String _eventDescription = '';
  String _eventLocation = '';
  DateTime? _dateDebut;
  DateTime? _dateFin;
  String? _selectedOrganizer;

  Future<void> _selectDate(
      BuildContext context, DateTime initialDate, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(
          2101), // Assuming events can be scheduled far into the future
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _dateDebut = pickedDate;
        } else {
          _dateFin = pickedDate;
        }
      });
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the event name';
    } else if (value.length < 3 || value.length > 30) {
      return 'Name should be between 3 and 30 characters';
    }
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the event location';
    } else if (value.length < 3 || value.length > 50) {
      return 'Location should be between 3 and 50 characters';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value != null && (value.length < 10 || value.length > 500)) {
      return 'Description should be between 10 and 500 characters';
    }
    return null;
  }

  String? _validateDate() {
    if (_dateDebut == null || _dateFin == null) {
      return 'Please select both start and end dates';
    } else if (_dateDebut!.isAfter(_dateFin!)) {
      return 'Start date should be before end date';
    } else if (_dateDebut!.isBefore(DateTime.now())) {
      return 'Start date should be in the future';
    }
    return null;
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
            'Add Event',
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
                              labelText: 'Event Name',
                            ),
                            validator: _validateName,
                            onSaved: (value) {
                              _eventName = value ?? '';
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Event Name',
                            ),
                            validator: _validateName,
                            onSaved: (value) {
                              _eventName = value ?? '';
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Event Description',
                            ),
                            maxLines: 3,
                            validator: _validateDescription,
                            onSaved: (value) {
                              _eventDescription = value ?? '';
                              print('event description: $_eventDescription');
                            },
                            onChanged: (value) {
                              // This will be called whenever the text in the field changes
                              print('Changed: $value');
                              // Update _eventDescription if needed
                              setState(() {
                                _eventDescription = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () async {
                              print('prompting chatgpt : $_eventDescription');
                              setState(() {
                                // Set a flag to indicate that the operation is in progress
                                _isLoading = true;
                              });

                              try {
                                String? generatedDescription =
                                    await EventWebService().generateWithChatGPT(
                                        _eventDescription, widget.token);

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
                                    _eventDescription = generatedDescription;
                                    _descriptionController.text =
                                        generatedDescription; // Update controller value
                                  });

                                  print(
                                      'Generated description: $_eventDescription');
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
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularProgressIndicator(),
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
                                          'images/openai-icon.png',
                                          width: 24.0,
                                          height: 24.0,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Generate with ChatGPT'),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Event Location',
                            ),
                            validator: _validateLocation,
                            onSaved: (value) {
                              _eventLocation = value ?? '';
                            },
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _selectDate(context,
                                    _dateDebut ?? DateTime.now(), true),
                                icon: const Icon(Icons.calendar_today,
                                    color: Color(0xff00689B)),
                                label: const Text('Select Start Date'),
                              ),
                              if (_dateDebut != null)
                                Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(_dateDebut!.toLocal()),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _selectDate(
                                    context, _dateFin ?? DateTime.now(), false),
                                icon: const Icon(Icons.calendar_today,
                                    color: Color(0xff00689B)),
                                label: const Text('Select End Date'),
                              ),
                              if (_dateFin != null)
                                Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(_dateFin!.toLocal()),
                                ),
                            ],
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
                                  // Validate date before saving the form data
                                  String? dateValidation = _validateDate();
                                  if (dateValidation != null) {
                                    SnackBar snackBar = SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(Icons.error,
                                              color: Colors.white),
                                          const SizedBox(width: 8),
                                          Text(dateValidation,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      backgroundColor: Colors
                                          .red, // Use red color for error messages
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    // Show a message or handle the validation error
                                  } else {
                                    // Proceed with form validation and saving data
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _formKey.currentState?.save();
                                      await EventWebService().addEventByAdmin(
                                        token: widget.token,
                                        userId: _selectedOrganizer!,
                                        name: _eventName,
                                        dateDebut: DateFormat('yyyy-MM-dd')
                                            .format(_dateDebut!.toLocal())
                                            .toString(),
                                        dateFin: DateFormat('yyyy-MM-dd')
                                            .format(_dateFin!.toLocal())
                                            .toString(),
                                        description: _eventDescription,
                                        lieu: _eventLocation,
                                        fileimage: _pickedImage!,
                                        context: context,
                                      );

                                      Navigator.pop(context);
                                    }
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
