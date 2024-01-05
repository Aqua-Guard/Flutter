import 'package:flutter/material.dart';
import 'package:aquaguard/Services/StoreWebService.dart' as networkService;
import 'package:aquaguard/Screens/Store/ProductDetailScreen.Dart';
import 'package:aquaguard/Screens/Store/ProductEditScreen.Dart';
import 'package:aquaguard/Screens/Store/ProductAddScreen.Dart';
import 'package:aquaguard/Models/Product.Dart';
import 'package:aquaguard/Screens/Store/ProductStatisticsScreen.Dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = []; // Initialize products as an empty list
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: products.isEmpty ? Center(child: CircularProgressIndicator()) : buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddScreen();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Product List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Product Statistics',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProductStatisticsScreen()),
            );
          }
        },
      ),
    );
  }

  Widget buildProductList() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 4.0,
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                'https://aquaguard-tux1.onrender.com/public/images/produit/${products[index].image}',
                fit: BoxFit.cover,
              ),
            ),
            title: Text(products[index].name),
            subtitle: Text('Price: \$${products[index].price.toStringAsFixed(2)}'),
            onTap: () {
              navigateToProductDetailScreen(products[index]);
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    navigateToEditScreen(products[index]);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteProduct(products[index].id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchProducts() async {
    try {
      List<dynamic> productListData = await networkService.ProductService.fetchProducts();

      List<Product> productsList = productListData
          .map((productData) => Product.fromJson(productData))
          .toList();

      setState(() {
        products = productsList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void navigateToProductDetailScreen(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  void navigateToAddScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductScreen()),
    );
    fetchProducts();
  }

  void navigateToEditScreen(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductEditScreen(product: product),
      ),
    ).then((_) {
      fetchProducts();
    });
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await networkService.ProductService.deleteProduct(productId);
      fetchProducts();
    } catch (e) {
      print('Error: $e');
    }
  }
}
