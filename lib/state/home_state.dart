// Generic HomeState classes
import 'package:TableTies/utils/resource.dart';

abstract class HomeState<T> {}

class HomeInitial<T> extends HomeState<T> {}

class HomeLoading<T> extends HomeState<T> {
  HomeLoading(String s);
}

class HomeSuccess<T> extends HomeState<T> {
  final Resource<T> resource;
  HomeSuccess(this.resource);
}

class HomeFailure<T> extends HomeState<T> {
  final Resource<T> resource;
  HomeFailure(this.resource);
}

class HomeProfileComplete<T> extends HomeState<T> {
  final Resource<bool> resource;
  HomeProfileComplete() : resource = Resource.success(true);
}

class HomeProfileIncomplete<T> extends HomeState<T> {
  final Resource<List<String>> resource;
  HomeProfileIncomplete({required List<String> missingFields})
      : resource = Resource.success(missingFields);
}
