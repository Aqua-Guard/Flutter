import 'package:aquaguard/Screens/user/usersScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../Components/MyAppBar.dart';
import '../../Models/userResponse.dart';
import '../../Services/userService.dart';

class UserStats extends StatefulWidget {
  const UserStats({super.key});

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  late List<UserResponse> userArray = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final storage = FlutterSecureStorage();
      var id = await storage.read(key: "id");

      var users = await UserService().fetchUsers(id!);
      setState(() {
        userArray = users;
      });
    } catch (error) {
      print('Error getting users: $error');
    }
  }

  Map<String, double> generateRoleDataMap() {
    Map<String, double> dataMap = {
      'Admins': 0.0,
      'Consommateurs': 0.0,
      'Partenaires': 0.0,
    };

    for (var user in userArray) {
      switch (user.role) {
        case 'admin':
          dataMap['Admins'] = dataMap['Admins']! + 1;
          break;
        case 'consommateur':
          dataMap['Consommateurs'] = dataMap['Consommateurs']! + 1;
          break;
        case 'partenaire':
          dataMap['Partenaires'] = dataMap['Partenaires']! + 1;
          break;
      }
    }

    return dataMap;
  }

  Map<String, double> generateActivatedAccountsDataMap() {
    Map<String, double> activatedAccountsDataMap = {
      'Activated': 0.0,
      'Desactivated': 0.0,
    };

    for (var user in userArray) {
      if (user.isActivated != null && user.isActivated!) {
        activatedAccountsDataMap['Activated'] =
            activatedAccountsDataMap['Activated']! + 1;
      } else {
        activatedAccountsDataMap['Desactivated'] =
            activatedAccountsDataMap['Desactivated']! + 1;
      }
    }

    return activatedAccountsDataMap;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> roleDataMap = generateRoleDataMap();
    Map<String, double> activatedAccountsDataMap =
        generateActivatedAccountsDataMap();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Statistics',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: const Color(0xff00689B),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, const Color.fromRGBO(42, 197, 255, 100)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ListView(
            children: [
              Card(
                margin: EdgeInsets.all(44.0),
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Users: ${userArray.length}',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UsersScreen()),
                          );
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  buildPieChart(roleDataMap, 'User Roles'),
                  buildPieChart(activatedAccountsDataMap, 'Activated Accounts'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPieChart(Map<String, double> dataMap, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 4,
        initialAngleInDegree: 0,
        chartType: ChartType.disc,
        centerText: title,
        legendOptions: LegendOptions(
          showLegendsInRow: true,
          legendPosition: LegendPosition.bottom,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
      ),
    );
  }
}
