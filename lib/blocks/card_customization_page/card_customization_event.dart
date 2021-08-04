part of 'card_customization_bloc.dart';

abstract class CardCutomizationEvent extends Equatable {
  const CardCutomizationEvent();

  @override
  List<Object> get props => [];
}

class SavePressed extends CardCutomizationEvent {
  final File  image;
  final String color;
  final String greyDegree;
  SavePressed(this.image, this.color, this.greyDegree);
}
