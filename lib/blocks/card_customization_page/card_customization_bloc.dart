import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


part 'card_customization_event.dart';
part 'card_customization_state.dart';

class CardCustomizationpageBloc extends Bloc<CardCutomizationEvent, CardCastomizationPageState> {
  CardCustomizationpageBloc() : super(CardCastomizationInitial());

  @override
  Stream<CardCastomizationPageState> mapEventToState(
      CardCutomizationEvent event,
      )async*{
    if(event is SavePressed){
      yield* _SavingProcess( event,event.image,event.color,event.greyDegree);
    }
  }

  Stream<CardCastomizationPageState> _SavingProcess(
      CardCutomizationEvent event,File _image,String color,String greyDegree,) async* {
    yield Saving();
    try {
      var stream =  http.ByteStream(DelegatingStream.typed(_image.openRead()));
      var length = await _image.length();
      var uri = Uri.parse("URL");
      var request = http.MultipartRequest("POST", uri);

      request.fields["color"] = color;
      request.fields["greyDegree"] = greyDegree;

      var multipartFile =  http.MultipartFile('image_file', stream, length, filename: basename(_image.path));

      request.files.add(multipartFile);

      await request.send().then((response) async {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });

      }).catchError((e) {
        print(e.toString());
      });
      yield Saved();
    }catch (err){
      yield SaveFailed();
    }
  }
}
