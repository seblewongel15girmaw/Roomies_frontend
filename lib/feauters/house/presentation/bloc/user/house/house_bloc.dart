import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:begara_mobile/feauters/house/data/model/house_model.dart';
import 'package:begara_mobile/feauters/house/domain/usecase/user/get_house_list.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_event.dart';
import 'package:begara_mobile/feauters/house/presentation/bloc/user/house/house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  GetHouseList getHouseList;
  HouseBloc(this.getHouseList) : super(InitialState()) {
    on<InitialEvent>(initialEvent);
    on<HouseDetailEvent>(houseDetailEvent);
    on<AddToFavoriteHouseEvent>(addToFavoriteHouseEvent);
    on<RemoveFromFavoriteHouseEvent>(removeFromFavoriteHouseEvent);
  }

  FutureOr<void> initialEvent(InitialEvent event,
      Emitter<HouseState> emit) async{
    emit(LoadingState());
    late List<HouseModel> houseList;
    try{
     houseList= await getHouseList();
     emit(HouseSuccessState(houseList: houseList));
    }
    catch(e){
      emit(HouseErrorState(error: e.toString()));
      log(e.toString());
    }
  }

  FutureOr<void> houseDetailEvent(HouseDetailEvent event,
      Emitter<HouseState> emit) {
  }

  FutureOr<void> addToFavoriteHouseEvent(AddToFavoriteHouseEvent event,
      Emitter<HouseState> emit) {
  }

  FutureOr<void> removeFromFavoriteHouseEvent(RemoveFromFavoriteHouseEvent event,
      Emitter<HouseState> emit) {
  }

}