abstract class BaseUseCase<T, Parameters> {
  Future<T> call(Parameters parameters);
}
