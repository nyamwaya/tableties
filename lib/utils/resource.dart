import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

// Resource class
class Resource<T> {
  final T? data;
  final String? error;
  final ResourceStatus status;

  Resource.loading() : this._(status: ResourceStatus.loading);
  Resource.success(T data) : this._(status: ResourceStatus.success, data: data);
  Resource.failure(String error)
      : this._(status: ResourceStatus.failure, error: error);

  Resource._({required this.status, this.data, this.error});
}

enum ResourceStatus { loading, success, failure }
