import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';

import '../providers/product.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
      id: '',
      title: '',
      description:'',
      price:0,
      imageUrl:'');
  var _initValues ={
      'title': '',
      'description':'',
      'price': '',
      'imageUrl':''};
  bool _isInit = true;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override// Because we cann't use ModalROute in initState
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isInit){
      final productId = ModalRoute.of(context)!.settings.arguments as dynamic;
      if(productId!= null){
        _editedProduct = Provider.of<Products>(context,listen: false).findById(productId);//here listen false is used to listen only one one time;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          //'imageUrl': _editedProduct.imageUrl
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
      _isInit = false;// because didChangeDependencies check multiple time
    }
    super.didChangeDependencies();
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
      setState(() {});
    }
  }
  void _saveForm(){
    final isValid = _form.currentState?.validate();
    if(!isValid!){
      return;
    }
    _form.currentState?.save();
    if(_editedProduct.id != null){
      Provider.of<Products>(context,listen: false).updateProduct(_editedProduct.id,_editedProduct);
    }else{
      Provider.of<Products>(context,listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: "$value",
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter The Title";
                  }
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    price: double.parse("$value"),
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter The Price";
                  };
                  if(double.tryParse(value)==null){
                    return "Please Enter A valid Number";
                  };
                  if(double.parse(value)<= 0){
                    return "Please Enter A valid price";
                  };

                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    description: "$value",
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter The description";
                  };
                  if(value.length<10){
                    return "Please Enter minimum 10 carecter";
                  };
                },

              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                      child: Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.cover,
                      ),
                    ),

                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: "$value",
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter The Image Url";
                        }
                        if(!value.startsWith("http") && !value.startsWith("https") ){
                          return "Please Enter A valid Url";
                        }
                        if(!value.endsWith(".png")&& !value.endsWith("jpg")&& !value.endsWith(".jpeg")){
                          return "Please Give a image Url";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
