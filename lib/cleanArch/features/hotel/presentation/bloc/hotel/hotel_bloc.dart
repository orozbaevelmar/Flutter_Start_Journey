import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:start_journey/cleanArch/core/common/entity/places_entity.dart';
import 'package:start_journey/cleanArch/core/common/model/load_more.dart';
import 'package:start_journey/cleanArch/features/hotel/data/model/hotel_model.dart';
import 'package:start_journey/cleanArch/features/hotel/domain/entities/hotel_list_entity.dart';
import 'package:start_journey/cleanArch/features/hotel/domain/usecases/get_all_hotels.dart';
import 'package:start_journey/cleanArch/features/hotel/data/model/hotel_list_model.dart';
import 'package:start_journey/old_stuffs/repository/response_body/response_body_hotel.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

@injectable
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
  void setHotelList(HotelListEntity anotherHotelList) {
    hotelList = anotherHotelList as HotelListModel;
  }

  HotelListEntity getHotelList() {
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

  Future<void> _getHotels(
      HotelLoadEvent event, Emitter<HotelState> emit) async {
    event.isInitial
        ? await _fetchInitialHotels(
            event.url,
            emit,
            'Hotels not Found',
            setHotelList,
            getHotelList,
          )
        : await _fetchMoreHotels(emit, setHotelList, getHotelList);
  }

  Future<void> _onFetchSearchedHotels(
      HotelSearchEvent event, Emitter<HotelState> emit) async {
    event.isInitial
        ? await _fetchInitialHotels(
            event.url,
            emit,
            'Not found Hotel with this name: "${event.hotelsNameContains}"',
            setExtraHotelListForSearchAndCategory,
            getExtraHotelListForSearchAndCategory,
          )
        : await _fetchMoreHotels(
            emit,
            setExtraHotelListForSearchAndCategory,
            getExtraHotelListForSearchAndCategory,
          );
  }

  Future<void> _getHotelAfterClearingSearchField(
      HotelAfterClearingSearchField event, Emitter<HotelState> emit) async {
    if ((getHotelList().results?.length ?? 0) > 0) {
      emit(HotelLoaded(hotelistModel: getHotelList()));
      return;
    }
    add(HotelLoadEvent(isInitial: true));
  }

  _fetchInitialHotels(
    String urlEvent,
    Emitter<HotelState> emit,
    String emptyListText,
    void Function(HotelListEntity anotherHotelList) setHotelListFunc,
    HotelListEntity Function() getHotelListFunc,
  ) async {
    emit(HotelLoading(message: 'Loading hotels....'));

    final response = await _getHotelsUsecase(urlEvent);

    response.fold(
      (l) => emit(HotelInitialError(message: 'Failed to load hotels')),
      (r) {
        setHotelListFunc(r as HotelListModel);

        bool isListEmpty = getHotelListFunc().results?.isEmpty ?? true;
        if (isListEmpty) {
          emit(HotelEmpty(message: emptyListText));
          return;
        }

        emit(HotelLoaded(hotelistModel: getHotelListFunc()));
      },
    );
  }

  _fetchMoreHotels(
    Emitter<HotelState> emit,
    void Function(HotelListEntity anotherHotelList) setHotelListFunc,
    HotelListEntity Function() getHotelListFunc,
  ) async {
    emit(HotelLoaded(
        hotelistModel: getHotelListFunc(),
        loadingMore: LoadingMore(isLoading: true)));

    final response = await _getHotelsUsecase(getHotelListFunc().next ?? '');
    response.fold(
      (l) => emit(HotelLoaded(
          hotelistModel: getHotelListFunc(),
          loadingMore: LoadingMore(
              isLoading: false, errorMessage: 'Failed to load more hotels'))),
      (r) {
        List<PlacesEntity> res = r.results ?? [];
        setHotelListFunc(HotelListModel(
          count: r.count,
          next: r.next,
          previous: r.previous,
          results: (hotelList.results! + res) as List<HotelModel>,
        ));

        emit(HotelLoaded(
            hotelistModel: getHotelListFunc(),
            loadingMore: LoadingMore(
              isLoading: false,
            )));
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
