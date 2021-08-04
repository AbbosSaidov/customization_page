part of 'card_customization_bloc.dart';

abstract class CardCastomizationPageState extends Equatable {
  const CardCastomizationPageState();

  @override
  List<Object> get props => [];
}

class CardCastomizationInitial extends CardCastomizationPageState {}

class Saved extends CardCastomizationPageState {}

class SaveFailed extends CardCastomizationPageState {}
class Saving extends CardCastomizationPageState {}

