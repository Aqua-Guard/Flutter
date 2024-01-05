import 'package:flutter/material.dart';
import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Components/MyDrawer.dart';
import 'package:aquaguard/Models/reclamation.dart';
import 'package:aquaguard/Services/ReclamationWebService.dart';
import 'package:aquaguard/Screens/reclamation/DisctutionScreen.dart';

class ReclamationScreen extends StatefulWidget {
  String token;

  ReclamationScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<ReclamationScreen> createState() => _ReclamationScreenState();
}

class _ReclamationScreenState extends State<ReclamationScreen> {
  int _selectedIndex = 5;
  late List<Reclamation> reclamationData = [];
  late TextEditingController _searchController;
  List<Reclamation> reclamationDataOriginal = [];
  bool isSmartSearchMode = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    ReclamationWebService().fetchReclamation(widget.token).then((reclamation) {
      setState(() {
        reclamationData = reclamation;
        reclamationDataOriginal = List.from(reclamationData);
      });
    }).catchError((error) {
      print('Error fetching reclamation: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (reclamationData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      child: Scaffold(
        appBar: MyAppBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_splash_screen.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDataTable(),
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: MyDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    if (reclamationData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/calendar_amico.png",
              height: 100,
            ),
            const SizedBox(height: 8.0),
            const Text("No Reclamations Found"),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        elevation: 4,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Reclamation Title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00689B),
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 150,
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00689B),
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00689B),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Actions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00689B),
                  ),
                ),
              ),
            ],
            rows: reclamationData.map((reclamation) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      reclamation.title,
                      softWrap: true,
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 150,
                      child: Text(
                        reclamation.description,
                        softWrap: true,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      reclamation.date,
                      softWrap: true,
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.info, color: Colors.blue),
                      onPressed: () {
                        _navigateToDiscutionScreen(reclamation.idreclamation, widget.token);
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _navigateToDiscutionScreen(String reclamationId, String token) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscutionScreen(token: token, reclamationId: reclamationId),
      ),
    );
  }
}
