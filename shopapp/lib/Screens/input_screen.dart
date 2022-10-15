// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/product_controller.dart';
import 'package:shopapp/Screens/home_screen.dart';
import 'package:shopapp/Screens/product_overviewScreen.dart';

class ProductInputScreen extends StatefulWidget {
  const ProductInputScreen({Key? key}) : super(key: key);

  static const routeName = '/product_input_screen';

  @override
  State<ProductInputScreen> createState() => _ProductInputScreenState();
}

class _ProductInputScreenState extends State<ProductInputScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _oldpriceController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _ownerController = TextEditingController();


  bool _isLoading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _oldpriceController.dispose();
    _categoryController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _ownerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enter a Product'),
          centerTitle: true,
          //backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushNamed(ProductOverView.routeName);
          }, icon: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                cursorHeight: 25,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _titleController.text = value;
                  _titleController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _titleController.text.length));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _oldpriceController,
                cursorHeight: 25,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Old Price',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _oldpriceController.text = value;
                  _oldpriceController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _oldpriceController.text.length));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _priceController,
                cursorHeight: 25,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _priceController.text = value;
                  _priceController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _priceController.text.length));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptionController,
                cursorHeight: 25,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _descriptionController.text = value;
                  _descriptionController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _descriptionController.text.length));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _categoryController,
                cursorHeight: 25,
                keyboardType: TextInputType.text,
                //maxLines: 5,
                decoration: const InputDecoration(
                  helperText: 'clothes, electronics, fruits, shoes, furniture, others',
                  hintText: 'Category',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _categoryController.text = value;
                  _categoryController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _categoryController.text.length));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _ownerController,
                cursorHeight: 25,
                keyboardType: TextInputType.text,
               // maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Owner\'s name',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _ownerController.text = value;
                  _ownerController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _ownerController.text.length));
                },
              ),
              
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _locationController,
                cursorHeight: 25,
                keyboardType: TextInputType.text,
               // maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Location',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _locationController.text = value;
                  _locationController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _locationController.text.length));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _phoneController,
                cursorHeight: 25,
                keyboardType: TextInputType.phone,
                //maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  _phoneController.text = value;
                  _phoneController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _phoneController.text.length));
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _imageUrlController,
                      cursorHeight: 25,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        hintText: 'Image Url',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        _imageUrlController.text = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await context.read<ProductController>().addToDb(
                      context,
                      DateTime.now().toIso8601String(),
                      _titleController.text,
                      _descriptionController.text,
                      double.parse(_oldpriceController.text),
                      double.parse(_priceController.text),
                      _categoryController.text,
                      _ownerController.text,
                      _locationController.text,
                      int.parse(_phoneController.text),
                      _imageUrlController.text);
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.deepPurple),
                        child: Text('Save Product',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
              )
            ],
          ),
        )));
  }
}
