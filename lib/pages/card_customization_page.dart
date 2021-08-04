import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';


import '../blocks/card_customization_page/card_customization_bloc.dart';

class CardCustomizationPage extends StatefulWidget {
  @override
  _CardCustomizationState createState() => _CardCustomizationState();
}

class _CardCustomizationState extends State<CardCustomizationPage> {
  int scrollL=1;
  String dropdownValue =null;
  double _currentSliderValue = 20;
  bool picked=false;
  File pickedImage;
  List<String> list_items=['black', 'white','green', 'red','blue', 'yellow',];
  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => CardCustomizationpageBloc(),
      child: BlocBuilder<CardCustomizationpageBloc, CardCastomizationPageState>(
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                title: const Text("Card Customization Page"),
              ),
              body: BlocBuilder<CardCustomizationpageBloc, CardCastomizationPageState>(
                builder: (context, state){
                  if (state is Saving) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Saved  || state is CardCastomizationInitial){
                    return mainWidget(state,context);
                  }else{
                    return const Center(
                      child: Text("Error Occurred"),
                    );
                  }
                },
              ),
            );
          }),
    );
  }
  Widget mainWidget(var state,var contextBloc){
    CardCustomizationpageBloc cardCustomizationpageBloc = BlocProvider.of<CardCustomizationpageBloc>(contextBloc);
    return ListView(
      children: [
        Container(height: 10,),
        const Center(
          child:Text(
              "Select background image",
            style: TextStyle(

              fontSize: 17
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20),
            child:  Card(
              child: InkWell(
                onTap: (){saveImage();},
                child: picked?Container(
                  height: 200,
                  child:PhotoView(
                    backgroundDecoration: BoxDecoration(color: Colors.white),
                    imageProvider: FileImage(pickedImage),
                  ) ,
                ):Container(
                  color: Colors.blue,
                  height: 200,
                ),
              ),
            )
        ),
        Container(height: 10,),
        Padding(
          padding: const EdgeInsets.all(20),child: Container(

          //height: 46,
          padding: const EdgeInsets.all(3.0),

          child:Center(child: DropdownButton<String>(
            selectedItemBuilder: (BuildContext context)
            {
              return list_items.map<Widget>((String item) {
                return Row(children: [Text(item),Icon(Icons.arrow_drop_down_sharp,color: Colors.white,)],);
              }).toList();
            },
            style: TextStyle(color: Colors.white),
            dropdownColor: Colors.blue,
            value: dropdownValue,

            hint:Row(children: const [Text("Select background Color",
              style: TextStyle(color: Colors.white),),Icon(Icons.arrow_drop_down_sharp,color: Colors.white,)],),
            icon: Visibility (visible:false, child: Icon(Icons.arrow_downward,color: Colors.white,)),
            //  iconSize: 24,
            //  elevation: 16,
            //style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              //      height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged:(String newValue){
              dropdownValue = newValue;

              setState((){});
            },items:
          list_items.map((String item) {
            return DropdownMenuItem<String>(
              child: Text('$item'),
              value: item,
            );
          }).toList(),
          ),),
          decoration: BoxDecoration(
             color: Colors.blue,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5),
          ),
        ),),
        const Center(
          child:Text(
            "Select blur degree",
            style: TextStyle(

                fontSize: 17
            ),
          ),
        ),
        Slider(
          value: _currentSliderValue,
          min: 0,
          max: 100,
          divisions: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        Container(height: 10,),
        Padding(
            padding: const EdgeInsets.all(20),
            child:  Card(
              child: InkWell(
                onTap: (){
                  cardCustomizationpageBloc.add(
                      SavePressed(pickedImage,dropdownValue,_currentSliderValue.toString()));
                },
                child: Container(
                  color: Colors.red,
                  height: 60,
                  child: Center(child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 21)),),
                ),
              ),
            )
        ),
      ],
    );
  }

  Future saveImage()async{
    try {

    final ImagePicker _picker = ImagePicker();
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    picked=true;
    pickedImage=File(image.path);
    setState((){});

    } catch (eror){
      print('error taking picture ${eror.toString()}');
    }
  }
}
