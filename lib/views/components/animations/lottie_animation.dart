enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  error(name: 'error'),
  lodaing(name: 'lodaing'),
  smallError(name: 'small_error'),
  empty(name: 'empty');

  final String name;

  const LottieAnimation({required this.name});
}
