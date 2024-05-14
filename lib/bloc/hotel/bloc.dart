import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start_journey/bloc/load_more/load_more.dart';
import 'package:start_journey/model/hotel.dart';
import 'package:start_journey/repository/hotel.dart';

part 'event.dart';
part 'state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(HotelInitial()) {
    on<HotelLoadEvent>(_getHotels);
  }

  HotelsModel hotelsModel = HotelsModel(
    count: 0,
    next: null,
    previous: null,
    results: [],
  );

  _getHotels(HotelLoadEvent event, emit) async {
    bool isInitial = hotelsModel.next == null;
    String url = '';
    if (isInitial) {
      url = '<--MString.BASE_URL-->/hotel/';
      emit(HotelInitialLoading(message: 'Loading hotels....'));
    } else {
      url = hotelsModel.next ?? '';

      emit(HotelLoaded(
          hotelsModel: hotelsModel,
          loading: LoadingMore(message: 'Loading more data...')));
    }

    final response = await HotelRepository.getHotels(url: url);
    response.fold(
      (l) => isInitial
          ? emit(HotelInitialError(message: 'Failed to load hotels'))
          : emit(HotelLoaded(
              hotelsModel: hotelsModel,
              error: LoadMoreError(message: 'Failed to load more hotels'))),
      (r) {
        if (isInitial) {
          hotelsModel = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: r.results,
          );
          bool isListEmpty = hotelsModel.results?.isEmpty ?? true;
          if (isListEmpty) {
            emit(HotelEmpty());
          }
        } else {
          List<Results> res = r.results ?? [];

          hotelsModel = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: hotelsModel.results! + res,
          );
        }
        emit(HotelLoaded(hotelsModel: hotelsModel));
      },
    );
  }
}
