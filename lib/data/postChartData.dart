import 'dart:math';

import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';
import 'package:aquaguard/Models/post.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PostChartData {
  static BarChartGroupData makeGroupData(
      int x, double y1, Color barColor, double width) {
    return BarChartGroupData(
      barsSpace: 1,
      x: x,
      barRods: [
        BarChartRodData(
          toY: 10.0, // Provide a value for toY
          color: barColor,
          width: width,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ],
    );
  }

  static List<BarChartGroupData> getBarChartitems(Color color,
      {double width = 20}) {
    return [
      makeGroupData(0, 2, color, width),
      makeGroupData(1, 1, color, width),
      makeGroupData(2, 2, color, width),
      makeGroupData(3, 3, color, width),
      makeGroupData(4, 1, color, width),
      makeGroupData(5, 0, color, width),
      makeGroupData(6, 1, color, width),
    ];
  }

static List<BarChartGroupData> getBarChartItems(List<double> data) {
    List<Color> colors = [Colors.blue, Colors.green, Colors.orange, Colors.red, Colors.purple, Colors.yellow, Colors.teal];
   
    int itemCount = min(data.length, colors.length);

    return List.generate(itemCount, (index) => makeGroupData(index, data[index], colors[index], 20));
  }

  // Create some dummy comments


  // static List<Transaction> get transactions {
  //   return [
  //     Transaction(
  //       "45673",
  //       "Spotify",
  //       DateTime.now(),
  //       569.50,
  //       TransactionType.outgoing,
  //       "https://i.cbc.ca/1.6128145.1628713609!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_940/regina-john-doe.jpg",
  //     ),
  //     Transaction(
  //       "76154",
  //       "Transfer",
  //       DateTime.now(),
  //       350.50,
  //       TransactionType.incoming,
  //       "https://i.cbc.ca/1.6128145.1628713609!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_940/regina-john-doe.jpg",
  //     ),
  //     Transaction(
  //       "322587",
  //       "Investments",
  //       DateTime.now(),
  //       3448.99,
  //       TransactionType.outgoing,
  //       "https://i.cbc.ca/1.6128145.1628713609!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_940/regina-john-doe.jpg",
  //     ),
  //   ];
  // }

  // static List<Expense> get otherExpanses {
  //   return [
  //     Expense(
  //       color: Styles.defaultBlueColor,
  //       expenseName: "Other expenses",
  //       expensePercentage: 50,
  //     ),
  //     Expense(
  //       color: Styles.defaultRedColor,
  //       expenseName: "Entertainment",
  //       expensePercentage: 35,
  //     ),
  //     Expense(
  //       color: Styles.defaultYellowColor,
  //       expenseName: "Investments",
  //       expensePercentage: 15,
  //     )
  //   ];
  // }
}
