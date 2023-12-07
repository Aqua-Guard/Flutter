import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventForm extends StatefulWidget {
  const AddEventForm({Key? key}) : super(key: key);

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables to store form data
  String _eventName = '';
  String _eventDescription = '';
  String _eventLocation = '';
  DateTime? _dateDebut;
  DateTime? _dateFin;
  String _organizer = ''; // You may need to fetch the list of organizers

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
    } else if (value.length < 3 || value.length > 30) {
      return 'Location should be between 3 and 30 characters';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value != null && (value.length < 10 || value.length > 100)) {
      return 'Description should be between 10 and 100 characters';
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
          child: 
                 Card(
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
                            onPressed: () {
                              // Handle image selection
                            },
                            icon: const Icon(Icons.image, color: Color(0xff00689B)),
                            label: const Text('Add Image'),
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
                              labelText: 'Event Description',
                            ),
                            maxLines: 3,
                            validator: _validateDescription,
                            onSaved: (value) {
                              _eventDescription = value ?? '';
                            },
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
                                onPressed: () => _selectDate(
                                    context, _dateDebut ?? DateTime.now(), true),
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
                            value: _organizer.isNotEmpty ? _organizer : 'Malek Labidi',
                            onChanged: (value) {
                              setState(() {
                                _organizer = value ?? 'Malek Labidi';
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'Malek Labidi',
                                child: Text('Malek Labidi'),
                              ),
                              DropdownMenuItem(
                                value: 'Youssef Farhat',
                                child: Text('Youssef Farhat'),
                              ),
                              DropdownMenuItem(
                                value: 'Mohamed Kout',
                                child: Text('Mohamed Kout'),
                              ),
                              DropdownMenuItem(
                                value: 'Amira Ben Mbarek',
                                child: Text('Amira Ben Mbarek'),
                              ),
                              DropdownMenuItem(
                                value: 'Adem Seddik',
                                child: Text('Adem Seddik'),
                              ),
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Organizer',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Validate date before saving the form data
                                  String? dateValidation = _validateDate();
                                  if (dateValidation != null) {
                                    // Show a message or handle the validation error
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(dateValidation),
                                      ),
                                    );
                                  } else {
                                    // Proceed with form validation and saving data
                                    if (_formKey.currentState?.validate() ?? false) {
                                      _formKey.currentState?.save();
                                      // Save the form data or perform any other action
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
      )
    ;
  }
}
