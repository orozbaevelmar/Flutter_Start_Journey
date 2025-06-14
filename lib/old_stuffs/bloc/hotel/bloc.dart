import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/old_stuffs/bloc/load_more/load_more.dart';
import 'package:start_journey/old_stuffs/model/extra/results.dart';
import 'package:start_journey/old_stuffs/model/hotel.dart';
import 'package:start_journey/old_stuffs/repository/hotel.dart';
import 'package:start_journey/old_stuffs/repository/real_repo.dart';
import 'package:start_journey/old_stuffs/repository/response_body/response_body_hotel.dart';
import 'package:start_journey/old_stuffs/utils/constants/m_strings.dart';

part 'event.dart';
part 'state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(HotelInitial()) {
    on<HotelLoadEvent>(_getHotelsVisual);
    on<HotelSearchEvent>(_getSearchedHotelsVisualisation);
  }

  HotelsModel hotelsModel = HotelsModel(
    count: 0,
    next: null,
    previous: null,
    results: [],
  );
  String url = '';
  _getHotelsVisual(HotelLoadEvent event, emit) async {
    bool isInitial = hotelsModel.next == null;
    if (isInitial) {
      url = HowLooksFetchedDataHotel.fetchedResponseBodyVisualisation;

      //'<--MString.BASE_URL-->/hotel/';
      emit(HotelInitialLoading(message: 'Loading hotels....'));
    } else {
      url = HowLooksFetchedDataHotel.fetchedResponseBodyVisualisation2;
      //url = hotelsModel.next ?? '';

      emit(HotelLoaded(
          hotelsModel: hotelsModel,
          loading: LoadingMore(message: 'Loading more data...')));
    }

    final response = await HotelRepository.getHotelsVisualisation(url: url);

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
          List<Result> res = r.results ?? [];

          hotelsModel = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: hotelsModel.results! + res,
          );
        }
        for (int i = 0; i < (r.results?.length ?? 0); i++) {
          print('${r.results![i].name} ===${r.results![i].isFavorite}');
        }
        emit(HotelLoaded(hotelsModel: hotelsModel));
      },
    );
  }

  HotelsModel searchedHotels = HotelsModel(
    count: 0,
    next: null,
    previous: null,
    results: [],
  );
  _getSearchedHotelsVisualisation(HotelSearchEvent event, emit) async {
    bool isInitial = event.isInitial;
    String url = '';
    if (isInitial) {
      searchedHotels = HotelsModel(
        count: 0,
        next: null,
        previous: null,
        results: [],
      );
      url = HowLooksFetchedDataHotel.searchCompleted(event.hotelsNameContains);
      //url = "${MString.BASE_URL}/hotels/&name=${event.hotelsNameContains}";
      emit(HotelInitialLoading(message: 'Fetching hotels....'));
    } else {
      url = searchedHotels.next ?? '';

      emit(HotelLoaded(
          hotelsModel: searchedHotels,
          loading: LoadingMore(message: 'Fetching more hotels...')));
    }

    final response = await HotelRepository.getHotelsVisualisation(url: url);
    response.fold(
      (l) => isInitial
          ? emit(HotelInitialError(message: 'Failed to load hotels'))
          : emit(HotelLoaded(
              hotelsModel: searchedHotels,
              error: LoadMoreError(message: 'Failed to load more hotels'))),
      (r) {
        if (isInitial) {
          searchedHotels = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: r.results,
          );
          bool isListEmpty = searchedHotels.results?.isEmpty ?? true;

          if (isListEmpty) {
            emit(HotelEmpty());
            return;
          }
        } else {
          //Adding products to existing list
          List<Result> res = r.results ?? [];

          searchedHotels = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: searchedHotels.results! + res,
          );
        }
        emit(HotelLoaded(hotelsModel: searchedHotels));
      },
    );
  }

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

  _getSearchedHotelsInReality(HotelSearchEvent event, emit) async {
    bool isInitial = event.isInitial;
    String url = '';
    if (isInitial) {
      searchedHotels = HotelsModel(
        count: 0,
        next: null,
        previous: null,
        results: [],
      );
      url = "${MString.BASE_URL}/hotels/&name=${event.hotelsNameContains}";
      emit(HotelInitialLoading(message: 'Fetching hotels....'));
    } else {
      url = searchedHotels.next ?? '';

      emit(HotelLoaded(
          hotelsModel: searchedHotels,
          loading: LoadingMore(message: 'Fetching more hotels...')));
    }

    final response = await HotelRepository.getHotelsVisualisation(url: url);
    response.fold(
      (l) => isInitial
          ? emit(HotelInitialError(message: 'Failed to load hotels'))
          : emit(HotelLoaded(
              hotelsModel: searchedHotels,
              error: LoadMoreError(message: 'Failed to load more hotels'))),
      (r) {
        if (isInitial) {
          searchedHotels = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: r.results,
          );
          bool isListEmpty = searchedHotels.results?.isEmpty ?? true;

          if (isListEmpty) {
            emit(HotelEmpty());
            return;
          }
        } else {
          //Adding products to existing list
          List<Result> res = r.results ?? [];

          searchedHotels = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: searchedHotels.results! + res,
          );
        }
        emit(HotelLoaded(hotelsModel: searchedHotels));
      },
    );
  }

  _getHotelsInReality(HotelLoadEvent event, emit) async {
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

    final response =
        await HotelRepositoryInReality.getHotelsInReality(url: url);
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
          List<Result> res = r.results ?? [];

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
