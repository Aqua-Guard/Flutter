import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:aquaguard/Models/Product.Dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff00689B), // Set app bar background color
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_splash_screen.jpg'), // Set your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
              child: Image.network(
  product.image,
  fit: BoxFit.cover,
  height: 200,
  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
    return Container(
      color: Colors.grey, // Placeholder color or any UI widget
      height: 200, // Set placeholder height to match the original height
      child: Center(
        child: Icon(
          Icons.error_outline, // Placeholder icon for error
          color: Colors.red, // Error icon color
          size: 50.0, // Error icon size
        ),
      ),
    );
  },
),

                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Price: ${product.price.toStringAsFixed(1)} PT',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Description: ${product.description}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Category: ${product.category}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Quantity: ${product.quantity.toStringAsFixed(0)} Articles remaining',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
