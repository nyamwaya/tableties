class Resource<T> {
  final T? data;
  final String? message;
  final ResourceStatus status;

  Resource.loading()
      : data = null,
        message = null,
        status = ResourceStatus.loading;
  Resource.success(this.data)
      : message = null,
        status = ResourceStatus.success;
  Resource.failure(this.message)
      : data = null,
        status = ResourceStatus.failure;
}

enum ResourceStatus { loading, success, failure }
