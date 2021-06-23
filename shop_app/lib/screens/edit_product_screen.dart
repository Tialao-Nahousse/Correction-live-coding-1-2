import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../providers/product.dart';



class EditProductScreen extends StatefulWidget {
  static const routeName ='/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(id: null, title: '', description: '', price: 0, imageUrl: 'imageUrl');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {
        
      });
    }
  }

  void _saveForm() {
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier produit"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save),
            ),
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null, 
                    title: value, 
                    description: _editedProduct.description, 
                    price: _editedProduct.price, 
                    imageUrl: _editedProduct.imageUrl
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null, 
                    title: _editedProduct.title, 
                    description: _editedProduct.description, 
                    price: double.parse(value), 
                    imageUrl: _editedProduct.imageUrl
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null, 
                    title: _editedProduct.title, 
                    description: value, 
                    price: _editedProduct.price, 
                    imageUrl: _editedProduct.imageUrl
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey
                      )
                    ),
                    child: _imageUrlController.text.isEmpty? Text("Entrer une url"): FittedBox(
                      child: Image.network(_imageUrlController.text,),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Image url"
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                       onSaved: (value) {
                        _editedProduct = Product(
                          id: null, 
                          title: _editedProduct.title, 
                          description: _editedProduct.description, 
                          price: _editedProduct.price, 
                          imageUrl: value
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}