import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_journey/old_stuffs/bloc/load_more/load_more.dart';
import 'package:start_journey/old_stuffs/model/extra/results.dart';
import 'package:start_journey/old_stuffs/model/sights.dart';
import 'package:start_journey/old_stuffs/repository/response_body/response_body_sights.dart';
import 'package:start_journey/old_stuffs/repository/sights.dart';

part 'event.dart';
part 'state.dart';

class SightsBloc extends Bloc<SightsEvent, SightsState> {
  SightsBloc() : super(SightsInitial()) {
    on<SightsLoadEvent>(_getSightsVisual);
    on<SightsSearchEvent>(_getSearchedSightsVisualisation);
  }

  SightsModel sightsModel = SightsModel(
    count: 0,
    next: null,
    previous: null,
    results: [],
  );

  _getSightsVisual(SightsLoadEvent event, emit) async {
    bool isInitial = sightsModel.next == null;
    String url = '';
    if (isInitial) {
      url = HowLooksFetchedDataSights.fetchedResponseBodyVisualisation;
      //'<--MString.BASE_URL-->/sights/';
      emit(SightsInitialLoading(message: 'Loading sights....'));
    } else {
      url = sightsModel.next ?? '';

      emit(SightsLoaded(
          sightsModel: sightsModel,
          loading: LoadingMore(message: 'Loading more data...')));
    }

    final response = await SightsRepository.getSightsVisualisation(url: url);
    response.fold(
      (l) => isInitial
          ? emit(SightsInitialError(message: 'Failed to load sights'))
          : emit(SightsLoaded(
              sightsModel: sightsModel,
              error: LoadMoreError(message: 'Failed to load more sights'))),
      (r) {
        if (isInitial) {
          sightsModel = SightsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: r.results,
          );
          bool isListEmpty = sightsModel.results?.isEmpty ?? true;
          if (isListEmpty) {
            emit(SightsEmpty());
          }
        } else {
          //   print('ABCC');

          List<Result> res = r.results ?? [];
          //  print('new result ===${res[0].name}');

          sightsModel = SightsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: sightsModel.results! + res,
          );
        }
        emit(SightsLoaded(sightsModel: sightsModel));
      },
    );
  }

  SightsModel searchedSights = SightsModel(
    count: 0,
    next: null,
    previous: null,
    results: [],
  );
  _getSearchedSightsVisualisation(SightsSearchEvent event, emit) async {
    bool isInitial = event.isInitial;
    String url = '';
    if (isInitial) {
      searchedSights = SightsModel(
        count: 0,
        next: null,
        previous: null,
        results: [],
      );
      url = HowLooksFetchedDataSights.searchCompleted(event.sightsNameContains);

      emit(SightsInitialLoading(message: 'Fetching sights....'));
    } else {
      url = searchedSights.next ?? '';

      emit(SightsLoaded(
          sightsModel: searchedSights,
          loading: LoadingMore(message: 'Fetching more sights...')));
    }

    final response = await SightsRepository.getSightsVisualisation(url: url);
    response.fold(
      (l) => isInitial
          ? emit(SightsInitialError(message: 'Failed to load sights'))
          : emit(SightsLoaded(
              sightsModel: searchedSights,
              error: LoadMoreError(message: 'Failed to load more sights'))),
      (r) {
        if (isInitial) {
          searchedSights = SightsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: r.results,
          );
          bool isListEmpty = searchedSights.results?.isEmpty ?? true;

          if (isListEmpty) {
            emit(SightsEmpty());
            return;
          }
        } else {
          //Adding products to existing list
          List<Result> res = r.results ?? [];

          searchedSights = SightsModel(
            count: r.count,
            next: r.next,
            previous: r.previous,
            results: searchedSights.results! + res,
          );
        }
        emit(SightsLoaded(sightsModel: searchedSights));
      },
    );
  }
}
