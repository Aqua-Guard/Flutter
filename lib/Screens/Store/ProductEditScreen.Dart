import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aquaguard/Services/StoreWebService.dart' as networkService;
import 'package:aquaguard/Models/Product.Dart';
import 'dart:convert';
import 'dart:io';

class ProductEditScreen extends StatefulWidget {
  final Product product;

  ProductEditScreen({required this.product});

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    descriptionController.text = widget.product.description;
    priceController.text = widget.product.price.toString();
    quantityController.text = widget.product.quantity.toString();
    categoryController.text = widget.product.category;
  }

Future<void> updateProduct() async {
  Product updatedProduct = Product(
    id: widget.product.id,
    name: nameController.text,
    description: descriptionController.text,
    price: double.parse(priceController.text),
    quantity: int.parse(quantityController.text),
    image: _imageFile?.path ?? widget.product.image,
    category: categoryController.text,
  );
  try {
    await networkService.ProductService.updateProduct(updatedProduct.id, updatedProduct.toJson());
    Navigator.pop(context);
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    setState(() {
      _imageFile = pickedImage;
    });

    
    String fileName = pickedImage.path.split('/').last;
    print('File Name: $fileName');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _imageFile != null
                ? Image.file(File(_imageFile!.path))
                : Image.network(widget.product.image),
            ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateProduct();
              },
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
