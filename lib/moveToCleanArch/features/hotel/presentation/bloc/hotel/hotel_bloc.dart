import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/moveToCleanArch/core/common/entity/places_entity.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/data/model/hotel_model.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/entities/hotel_list_entity.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/domain/usecases/get_all_hotels.dart';
import 'package:start_journey/old_stuffs/bloc/load_more/load_more.dart';
import 'package:start_journey/moveToCleanArch/features/hotel/data/model/hotel_list_model.dart';
import 'package:start_journey/old_stuffs/repository/response_body/response_body_hotel.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final GetHotelsUseCase _getHotelsUsecase;
  HotelBloc({required GetHotelsUseCase getHotelsUsecase})
      : _getHotelsUsecase = getHotelsUsecase,
        super(HotelInitial()) {
    on<HotelLoadEvent>(_getHotels);
    on<HotelSearchEvent>(_onFetchSearchedHotels);
    on<HotelAfterClearingSearchField>(_getHotelAfterClearingSearchField);
  }

  /// --------------------------------------------------------------------------
  HotelListEntity hotelList = HotelListModel(
    count: null,
    next: null,
    previous: null,
    results: [],
  );
  void setHotelList1(HotelListEntity anotherHotelList) {
    hotelList = anotherHotelList as HotelListModel;
  }

  HotelListEntity getHotelList1() {
    return hotelList;
  }

  /// --------------------------------------------------------------------------
  HotelListModel extraHotelListForSearchAndCategory = HotelListModel(
    count: null,
    next: null,
    previous: null,
    results: [],
  );

  void setExtraHotelListForSearchAndCategory(HotelListEntity anotherHotelList) {
    extraHotelListForSearchAndCategory = anotherHotelList as HotelListModel;
  }

  HotelListEntity getExtraHotelListForSearchAndCategory() {
    return extraHotelListForSearchAndCategory;
  }

  /// --------------------------------------------------------------------------

  Future<void> _getHotelAfterClearingSearchField(
      HotelAfterClearingSearchField event, Emitter<HotelState> emit) async {
    if ((getHotelList1().results?.length ?? 0) > 0) {
      emit(HotelLoaded(hotelistModel: getHotelList1()));
      return;
    }
    add(HotelLoadEvent(isInitial: true));
  }

  Future<void> _getHotels(
      HotelLoadEvent event, Emitter<HotelState> emit) async {
    event.isInitial
        ? await _fetchInitialHotels(
            event.url,
            emit,
            'Нету отелей',
            setHotelList1,
            getHotelList1,
          )
        : await _fetchMoreHotels(emit, setHotelList1, getHotelList1);
  }

  Future<void> _onFetchSearchedHotels(
      HotelSearchEvent event, Emitter<HotelState> emit) async {
    event.isInitial
        ? await _fetchInitialHotels(
            event.url,
            emit,
            'Не нашлось таких отелей с названием "${event.hotelsNameContains}"',
            setExtraHotelListForSearchAndCategory,
            getExtraHotelListForSearchAndCategory,
          )
        : await _fetchMoreHotels(
            emit,
            setExtraHotelListForSearchAndCategory,
            getExtraHotelListForSearchAndCategory,
          );
  }

  _fetchInitialHotels(
    String urlEvent,
    Emitter<HotelState> emit,
    String emptyListText,
    void Function(HotelListEntity anotherHotelList) setHotelList,
    HotelListEntity Function() getHotelList,
  ) async {
    emit(HotelLoading(message: 'Loading hotels....'));

    final response = await _getHotelsUsecase(urlEvent);

    response.fold(
      (l) => emit(HotelInitialError(message: 'Failed to load hotels')),
      (r) {
        setHotelList(r as HotelListModel);

        bool isListEmpty = getHotelList().results?.isEmpty ?? true;
        if (isListEmpty) {
          emit(HotelEmpty(message: emptyListText));
          return;
        }

        emit(HotelLoaded(hotelistModel: getHotelList()));
      },
    );
  }

  _fetchMoreHotels(
    Emitter<HotelState> emit,
    void Function(HotelListEntity anotherHotelList) setHotelList,
    HotelListEntity Function() getHotelList,
  ) async {
    emit(HotelLoaded(
        hotelistModel: getHotelList(),
        loading: LoadingMore(message: 'Loading more Data...')));

    final response = await _getHotelsUsecase(getHotelList().next ?? '');
    response.fold(
      (l) => emit(HotelLoaded(
          hotelistModel: getHotelList(),
          error: LoadMoreError(message: 'Failed to load more Hotels'))),
      (r) {
        List<PlacesEntity> res = r.results ?? [];
        setHotelList(HotelListModel(
          count: r.count,
          next: r.next,
          previous: r.previous,
          results: (hotelList.results! + res) as List<HotelModel>,
        ));

        emit(HotelLoaded(hotelistModel: getHotelList()));
      },
    );
  }

  /* HotelsModel hotelsModel = HotelsModel(
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
          List<PlacesModel> res = r.results ?? [];

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
          List<PlacesModel> res = r.results ?? [];

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
          List<PlacesModel> res = r.results ?? [];

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
          List<PlacesModel> res = r.results ?? [];

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
  } */
}
