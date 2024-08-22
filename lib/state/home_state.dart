// Generic HomeState classes
import 'package:TableTies/utils/resource.dart';

abstract class HomeState<T> {}

class HomeInitial<T> extends HomeState<T> {}

class HomeLoading<T> extends HomeState<T> {}

class HomeSuccess<T> extends HomeState<T> {
  final Resource<T> resource;
  HomeSuccess(this.resource);
}

class HomeFailure<T> extends HomeState<T> {
  final Resource<T> resource;
  HomeFailure(this.resource);
}
