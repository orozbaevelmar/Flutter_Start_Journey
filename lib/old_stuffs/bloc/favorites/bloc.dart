import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/old_stuffs/bloc/load_more/load_more.dart';
import 'package:start_journey/old_stuffs/model/extra/results.dart';
import 'package:start_journey/old_stuffs/model/favorites.dart' as favorites;
import 'package:start_journey/old_stuffs/model/hotel.dart';
import 'package:start_journey/old_stuffs/repository/favorites.dart';
import 'package:start_journey/old_stuffs/repository/response_body/favorite.dart';
import 'package:start_journey/old_stuffs/utils/constants/m_strings.dart';

part 'event.dart';
part 'state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  HotelsModel favoritesModel = HotelsModel(
    count: 0,
    next: null,
    previous: null,
    results: [],
  );

  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesLoadEvent>(_getFavorites);
    on<FavoriteDrugRemoveEvent>(_deleteFavoriteDrugInReality);
  }

  _getFavorites(FavoritesLoadEvent event, emit) async {
    bool isInitial = favoritesModel.next == null;
    String url = '';
    if (isInitial) {
      favoritesModel = HotelsModel(
        count: 0,
        next: null,
        previous: null,
        results: [],
      );
      url = FavoriteData.favoriteData();
      //url = "${MString.BASE_URL}/hotels/&name=${event.hotelsNameContains}";
      emit(FavoritesInitialLoading(message: 'Fetching hotels....'));
    } else {
      url = favoritesModel.next ?? '';

      emit(FavoritesLoaded(
          favoritesModel: favoritesModel,
          loading: LoadingMore(message: 'Fetching more hotels...')));
    }

    final response =
        await FavoritesRepository.getFavoritesVisualisation(url: url);
    response.fold(
      (l) => isInitial
          ? emit(FavoritesInitialError(message: 'Failed to load hotels'))
          : emit(FavoritesLoaded(
              favoritesModel: favoritesModel,
              error: LoadMoreError(message: 'Failed to load more hotels'))),
      (r) {
        if (isInitial) {
          favoritesModel = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: r.results,
          );
          bool isListEmpty = favoritesModel.results?.isEmpty ?? true;

          if (isListEmpty) {
            emit(FavoritesEmpty());
          }
        } else {
          List<Result> res = r.results ?? [];

          favoritesModel = HotelsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: favoritesModel.results! + res,
          );
        }
        emit(FavoritesLoaded(favoritesModel: favoritesModel));
      },
    );
  }

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

  favorites.FavoritesModel favoritesModelInReality = favorites.FavoritesModel(
    count: 0,
    next: null,
    previous: null,
    results: [],
  );

  _deleteFavoriteDrugInReality(FavoriteDrugRemoveEvent event, emit) {
    favoritesModel.results?.remove(event.results);

    emit(FavoritesLoaded(favoritesModel: favoritesModel));
  }

  _getFavoritesInReality(FavoritesLoadEvent event, emit) async {
    bool isInitial = favoritesModel.next == null;
    String url = '';
    if (isInitial) {
      url = '${MString.BASE_URL}/favorites/';

      emit(FavoritesInitialLoading(message: 'Fetching products....'));
    } else {
      url = favoritesModel.next ?? '';

      emit(FavoritesLoaded(
          favoritesModel: favoritesModel,
          loading: LoadingMore(message: 'Fetching more products...')));
    }

    final response =
        await FavoritesRepositoryInReality.getFavoritesInReality(url: url);

    response.fold(
      (l) {
        return isInitial
            ? emit(FavoritesInitialError(message: 'Failed to load products'))
            : emit(FavoritesLoaded(
                favoritesModel: favoritesModel,
                error: LoadMoreError(message: 'Failed to load more products')));
      },
      (r) {
        if (isInitial) {
          /* favoritesModel = FavoritesModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: r.results,
          ); */
          bool isListEmpty = favoritesModel.results?.isEmpty ?? true;
          if (isListEmpty) {
            emit(FavoritesEmpty());
          }
        } else {
          /* List<Results> res = r.results ?? [];
          favoritesModel = FavoritesModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: favoritesModel.results! + res,
          ); */
        }
        emit(FavoritesLoaded(favoritesModel: favoritesModel));
      },
    );
  }
}
